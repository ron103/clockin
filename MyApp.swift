// MyApp.swift
import SwiftUI

struct ContentView: View {
    @StateObject var auth = AuthViewModel()
    @StateObject var devicesVM = DevicesViewModel()
    
    var body: some View {
        Group {
            if auth.isLoggedIn {
                MainTabView()
                    .environmentObject(auth)
                    .environmentObject(devicesVM)
            } else {
                LoginView()
                    .environmentObject(auth)
            }
        }
        .onChange(of: auth.email) { newEmail, _ in
            devicesVM.loadUserRecord(email: newEmail)
        }
        .onAppear {

            seedSampleData()
        }
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
