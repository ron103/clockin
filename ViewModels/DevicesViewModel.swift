
// ViewModels/DevicesViewModel.swift
import SwiftUI
import Combine

class DevicesViewModel: ObservableObject {
    @Published var isClockedIn: Bool = false
    @Published var clockInTime: Date? = nil
    @Published var elapsedTime: TimeInterval = 0
    @Published var isOnBreak: Bool = false
    @Published var breakStartTime: Date? = nil
    @Published var breakTime: TimeInterval = 0
    @Published var sessionWorkTime: TimeInterval = 0
    
    @Published var hourlyRate: Double = 15.0
    @Published var dailyGoal: TimeInterval = 6 * 3600
    @Published var currency: String = "USD"
    
    @Published var selectedTimeFrameIndex: Int = 0
    let timeFrames = ["Daily", "Weekly", "Monthly", "All time"]
    
    var workHistory: [WorkDayRecord] = []
    var userRecord: UserRecord?
    
    private var timerCancellable: AnyCancellable?
    
    init() {
        startTimer()
    }
    
    var currencySymbol: String {
        switch currency {
        case "USD": return "$"
        case "EUR": return "€"
        case "GBP": return "£"
        case "JPY": return "¥"
        default: return "$"
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimers()
            }
    }
    
    private func updateTimers() {
        guard isClockedIn else { return }
        let now = Date()
        if !isOnBreak, let lastTime = clockInTime {
            let delta = now.timeIntervalSince(lastTime)
            sessionWorkTime += delta
            elapsedTime = sessionWorkTime  // Only count work time (not break)
            clockInTime = now
        }
        if isOnBreak, let lastBreak = breakStartTime {
            let delta = now.timeIntervalSince(lastBreak)
            breakTime += delta
            breakStartTime = now
        }
    }
    
    func clockInOutTapped() {
        if !isClockedIn {
            sessionWorkTime = 0
            elapsedTime = 0
            breakTime = 0
            isClockedIn = true
            clockInTime = Date()
        } else {
            storeCurrentDayWork()
            resetTimers()
        }
    }
    
    func startEndBreakTapped() {
        guard isClockedIn else { return }
        if !isOnBreak {
            isOnBreak = true
            breakStartTime = Date()
        } else {
            isOnBreak = false
            breakStartTime = nil
            clockInTime = Date()
        }
    }
    
    private func storeCurrentDayWork() {
        let netWorkTime = sessionWorkTime
        guard netWorkTime > 0 else { return }
        let day = Calendar.current.startOfDay(for: Date())
        let currentRate = userRecord?.currentHourlyRate ?? self.hourlyRate
        if let index = workHistory.firstIndex(where: {
            Calendar.current.isDate($0.date, inSameDayAs: day) &&
            abs($0.hourlyRate - currentRate) < 0.001
        }) {
            workHistory[index].totalWork += netWorkTime
            if let uIndex = userRecord?.workHistory.firstIndex(where: {
                Calendar.current.isDate($0.date, inSameDayAs: day) &&
                abs($0.hourlyRate - currentRate) < 0.001
            }) {
                userRecord?.workHistory[uIndex].totalWork += netWorkTime
            }
        } else {
            let newRecord = WorkDayRecord(date: day, totalWork: netWorkTime, hourlyRate: currentRate)
            workHistory.append(newRecord)
            userRecord?.workHistory.append(newRecord)
        }
    }
    
    private func resetTimers() {
        isClockedIn = false
        isOnBreak = false
        clockInTime = nil
        breakStartTime = nil
        elapsedTime = 0
        breakTime = 0
        sessionWorkTime = 0
    }
    
    func getStats(for index: Int) -> (daysWorked: Int, totalTime: TimeInterval, averageTime: TimeInterval, totalEarnings: Double) {
        var filteredRecords: [WorkDayRecord]
        switch index {
        case 0:
            filteredRecords = workHistory.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
        case 1:
            filteredRecords = workHistory.filter { isDateInLast7Days($0.date) }
        case 2:
            filteredRecords = workHistory.filter { isDateInLast30Days($0.date) }
        case 3:
            filteredRecords = workHistory
        default:
            filteredRecords = workHistory
        }
        var totalTime = filteredRecords.reduce(0) { $0 + $1.totalWork }
        var daysWorked = filteredRecords.count
        var totalEarnings = filteredRecords.reduce(0) { $0 + (($1.totalWork / 3600) * $1.hourlyRate) }
        if isClockedIn {
            let currentSession = sessionWorkTime
            if !filteredRecords.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) }) {
                daysWorked += 1
            }
            totalTime += currentSession
            totalEarnings += (currentSession / 3600) * (userRecord?.currentHourlyRate ?? hourlyRate)
        }
        let averageTime = daysWorked > 0 ? totalTime / Double(daysWorked) : 0.0
        return (daysWorked, totalTime, averageTime, totalEarnings)
    }
    
    var metrics: [DeviceModel] {
        let stats = getStats(for: selectedTimeFrameIndex)
        let earningsStr = String(format: "\(currencySymbol)%.2f", stats.totalEarnings)
        let totalTimeStr = formatTime(stats.totalTime)
        let averageTimeStr = formatTime(stats.averageTime)
        let daysWorkedStr = String(stats.daysWorked)
        return [
            DeviceModel(name: "Total Earnings", detail: earningsStr),
            DeviceModel(name: "Total Time", detail: totalTimeStr),
            DeviceModel(name: "Average Time", detail: averageTimeStr),
            DeviceModel(name: "Days Worked", detail: daysWorkedStr)
        ]
    }
    
    private func isDateInLast7Days(_ date: Date) -> Bool {
        guard let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date()) else { return false }
        return date >= Calendar.current.startOfDay(for: sevenDaysAgo)
    }
    
    private func isDateInLast30Days(_ date: Date) -> Bool {
        guard let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -29, to: Date()) else { return false }
        return date >= Calendar.current.startOfDay(for: thirtyDaysAgo)
    }
    
    private func formatTime(_ totalSeconds: TimeInterval) -> String {
        let seconds = Int(totalSeconds) % 60
        let minutes = (Int(totalSeconds) / 60) % 60
        let hours   = Int(totalSeconds) / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func loadUserRecord(email: String) {
        if let user = UserDatabase.shared.getUser(email: email) {
            self.userRecord = user
            self.hourlyRate = user.currentHourlyRate
            self.dailyGoal = user.currentDailyGoal
            self.workHistory = user.workHistory
        }
    }
}
