//Views/Profile/ProfileView.swift
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var devicesVM: DevicesViewModel
    @EnvironmentObject var auth: AuthViewModel
    let currencies = ["USD", "EUR", "GBP", "JPY"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Hourly Rate")) {
                    HStack {
                        TextField("Hourly Rate", value: $devicesVM.hourlyRate, formatter: NumberFormatter.currency)
                            .keyboardType(.decimalPad)
                            .onChange(of: devicesVM.hourlyRate) { newValue, _ in
                                devicesVM.userRecord?.currentHourlyRate = newValue
                            }
                        Picker("", selection: $devicesVM.currency) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: 100)
                    }
                }
                Section(header: Text("Daily Hour Goal")) {
                    Stepper(value: $devicesVM.dailyGoal, in: 3600...24*3600, step: 1800) {
                        Text("\(String(format: "%.1f", devicesVM.dailyGoal / 3600)) hours")
                    }
                    .onChange(of: devicesVM.dailyGoal) { newValue, _ in
                        devicesVM.userRecord?.currentDailyGoal = newValue
                    }
                }
                Section {
                    Button(action: {
                        auth.deleteAccount()
                    }) {
                        Text("Delete Account")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        auth.signOut()
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Profile")
        }
    }
}
