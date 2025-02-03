
// Views/MainTabView.swift
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var auth: AuthViewModel
    @EnvironmentObject var devicesVM: DevicesViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .onAppear {
            if let user = UserDatabase.shared.getUser(email: auth.email) {
                devicesVM.userRecord = user
                devicesVM.hourlyRate = user.currentHourlyRate
                devicesVM.dailyGoal = user.currentDailyGoal
                devicesVM.workHistory = user.workHistory
            }
        }
    }
}
