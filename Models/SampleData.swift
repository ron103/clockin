
// Models/SampleData.swift
import Foundation

func seedSampleData() {
    let email = "admin@clockin.com"
    if UserDatabase.shared.getUser(email: email) != nil {
        // Sample user already exists.
        return
    }
    
    let sampleUser = UserRecord(email: email, firstName: "super", lastName: "user", hourlyRate: 15.0, dailyGoal: 6 * 3600)
    
    let calendar = Calendar.current
    let today = Date()
    // Start 60 days ago
    guard let startDate = calendar.date(byAdding: .day, value: -60, to: today) else { return }
    
    // For each day from startDate until today:
    for dayOffset in 0...60 {
        if let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) {
            // 30% chance off (0 hours), otherwise random between 1 and 8 hours.
            let workHours: Double = (Double.random(in: 0...1) < 0.3) ? 0 : Double(Int.random(in: 1...8))
            if workHours > 0 {
                let secondsWorked = workHours * 3600
                let record = WorkDayRecord(date: date, totalWork: secondsWorked, hourlyRate: sampleUser.currentHourlyRate)
                sampleUser.workHistory.append(record)
            }
        }
    }
    
    UserDatabase.shared.addUser(user: sampleUser)
}
