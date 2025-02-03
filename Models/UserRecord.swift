
// Models/UserRecord.swift
import Foundation

class UserRecord: ObservableObject {
    let email: String
    var firstName: String
    var lastName: String
    var workHistory: [WorkDayRecord]
    var currentHourlyRate: Double
    var currentDailyGoal: TimeInterval
    
    init(email: String, firstName: String, lastName: String, hourlyRate: Double, dailyGoal: TimeInterval) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.currentHourlyRate = hourlyRate
        self.currentDailyGoal = dailyGoal
        self.workHistory = []
    }
}

struct WorkDayRecord {
    let date: Date
    var totalWork: TimeInterval
    let hourlyRate: Double
}

class UserDatabase {
    static let shared = UserDatabase()
    private var users: [String: UserRecord] = [:] // key: email.lowercased()
    
    func getUser(email: String) -> UserRecord? {
        return users[email.lowercased()]
    }
    
    func addUser(user: UserRecord) {
        users[user.email.lowercased()] = user
    }
    
    func updateUser(user: UserRecord) {
        users[user.email.lowercased()] = user
    }
    
    func deleteUser(email: String) {
        users.removeValue(forKey: email.lowercased())
    }
}
