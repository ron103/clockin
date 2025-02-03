
// ViewModels/AuthViewModel.swift
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var firstName: String = ""
    @Published var email: String = ""
    @Published var loginError: String? = nil
    
    func signIn(email: String, password: String) {
        if let user = UserDatabase.shared.getUser(email: email) {
            self.firstName = user.firstName
            self.email = email
            self.isLoggedIn = true
            self.loginError = nil
        } else {
            self.loginError = "Email not found. Please sign up first."
            self.isLoggedIn = false
        }
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) {
        if UserDatabase.shared.getUser(email: email) != nil {
            self.loginError = "User already exists. Please sign in."
            return
        }
        let newUser = UserRecord(email: email, firstName: firstName, lastName: lastName, hourlyRate: 15.0, dailyGoal: 6 * 3600)
        UserDatabase.shared.addUser(user: newUser)
        self.firstName = newUser.firstName
        self.email = email
        self.isLoggedIn = true
        self.loginError = nil
    }
    
    func signOut() {
        isLoggedIn = false
        firstName = ""
        email = ""
    }
    
    func deleteAccount() {
        UserDatabase.shared.deleteUser(email: self.email)
        signOut()
    }
}
