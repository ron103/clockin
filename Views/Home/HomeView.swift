
// Views/Home/HomeView.swift

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var devicesVM: DevicesViewModel
    @EnvironmentObject var auth: AuthViewModel
    @State private var randomQuote: String = sampleQuotes.randomElement()!
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                headerView
                infoPanel
                timeFramePicker
                metricsGrid
                QuoteView(quote: randomQuote)
                Spacer()
            }
            .padding(.top)
            .navigationBarHidden(true)
            .background(Color(.systemBackground))
        }
    }
}

extension HomeView {
    private var headerView: some View {
        HStack {
            Image("LogoB")
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text("Hi \(auth.firstName)!")
                    .font(.headline)
                Text(Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Button(action: {
                // Additional settings action if needed.
            }) {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
    }
    
    private var infoPanel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(.systemGray6), Color(.systemGray5)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(formatTime(devicesVM.elapsedTime))
                        .font(.system(size: 36, weight: .bold, design: .monospaced))
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        devicesVM.clockInOutTapped()
                    }) {
                        Text(devicesVM.isClockedIn ? "Clock Out" : "Clock In")
                            .font(.caption.bold())
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(formatTime(devicesVM.breakTime))
                            .font(.subheadline.bold())
                        Text("Break time")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        let progress = (devicesVM.elapsedTime / devicesVM.dailyGoal) * 100
                        Text(String(format: "%.1f%%", progress))
                            .font(.subheadline.bold())
                        Text("Completed")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(String(format: "\(devicesVM.currencySymbol)%.2f", devicesVM.getStats(for: devicesVM.selectedTimeFrameIndex).totalEarnings))
                            .font(.subheadline.bold())
                        Text("Earnings")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        devicesVM.startEndBreakTapped()
                    }) {
                        Text(devicesVM.isOnBreak ? "End Break" : "Start Break")
                            .font(.caption.bold())
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!devicesVM.isClockedIn)
                    .opacity(devicesVM.isClockedIn ? 1.0 : 0.5)
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .frame(height: 160)
    }
    
    private var timeFramePicker: some View {
        Picker("Time Frame", selection: $devicesVM.selectedTimeFrameIndex) {
            ForEach(0..<devicesVM.timeFrames.count, id: \.self) { index in
                Text(devicesVM.timeFrames[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
    
    private var metricsGrid: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(devicesVM.metrics) { metric in
                    MetricCardView(metric: metric)
                }
            }
            .padding()
        }
    }
    
    private func formatTime(_ totalSeconds: TimeInterval) -> String {
        let seconds = Int(totalSeconds) % 60
        let minutes = (Int(totalSeconds) / 60) % 60
        let hours   = Int(totalSeconds) / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct MetricCardView: View {
    let metric: DeviceModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            VStack(spacing: 8) {
                Text(metric.name)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(metric.detail)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
            }
            .padding()
        }
        .frame(height: 120)
    }
}

