# Clockin – A Time Tracking Tool

Clockin is a cross-platform time tracking solution built with Swift, SwiftUI, and WatchKit. It provides a robust clock-in/clock-out system with real-time visual analytics for productivity and earnings. The app is designed for both iOS and watchOS, using a shared MVVM architecture to maintain consistent business logic across platforms.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Technologies](#technologies)
- [Architecture and Folder Structure](#architecture-and-folder-structure)
- [Installation and Setup](#installation-and-setup)
- [Usage](#usage)
- [Future Improvements](#future-improvements)
- [Credits](#credits)
- [License](#license)

## Overview

Clockin is a time tracking tool developed out of my own experiences as an international student juggling academics and part-time work. I noticed that every minute spent working was precious—and that the "earnings meter" running in our minds was a constant reminder of our dedication. With Clockin, users can seamlessly track their work time and breaks on both iOS and Apple Watch, view real-time analytics (such as net work time, break time, and earnings), and stay motivated to "clock in and lock in" their productivity.

## Features

### Cross-Platform Support:
- **iOS:** A detailed dashboard showing work statistics, earnings, and goal completion.
- **watchOS:** A minimal, page-based interface with three pages:
  - **Page 1:** Running clock with Clock In/Out and Start/End Break buttons.
  - **Page 2:** Total work time and break time.
  - **Page 3:** Earnings and goal completion percentage.

### Real-Time Analytics:
- Dynamically calculates net work time (excluding break periods) and updates earnings live based on a default hourly rate of $15/hr and a daily goal of 6 hours.
- Uses a dedicated `sessionWorkTime` property to ensure that when on break, work time and earnings remain frozen.

### Intuitive UI:
- iOS interface leverages SwiftUI for an engaging, modern dashboard.
- Apple Watch interface uses a page-based layout with simple navigation and clear visuals.

### Modular & Scalable Architecture:
- Implements an MVVM pattern with shared Models and ViewModels across iOS and watchOS.
- Uses an in-memory database for prototyping with an option to seed sample data.
- Ready to be extended with a persistent backend (e.g., Firebase, CloudKit) for production.

### User Data Management:
- Each user’s data (time records, earnings, etc.) is stored separately.
- Includes functionality for account deletion so users can re-sign-up with the same email if needed.

## Technologies
- Swift
- SwiftUI
- WatchKit
- MVVM Architecture

## Architecture and Folder Structure

```
MyApp
│
├── Models
│   ├── DeviceModel.swift       // Contains the DeviceModel struct.
│   ├── UserRecord.swift        // Contains UserRecord and WorkDayRecord.
│   ├── NumberFormatter+Extensions.swift   // Contains a NumberFormatter extension.
│   ├── SampleData.swift        // (Optional) Seeds sample data.
│
├── ViewModels
│   ├── AuthViewModel.swift     // Contains AuthViewModel.
│   ├── DevicesViewModel.swift  // Contains DevicesViewModel.
│
├── Views
│   ├── Authentication
│   │    ├── LoginView.swift    // iOS (and optionally watchOS) Login View.
│   │    ├── SignUpView.swift   // iOS (and optionally watchOS) Sign Up View.
│   ├── Home
│   │    ├── HomeView.swift     // iOS Home Dashboard.
│   │    ├── MetricCardView.swift   // Part of iOS Home.
│   │    ├── QuoteView.swift    // Contains sampleQuotes and QuoteView.
│   ├── Profile
│   │    ├── ProfileView.swift  // iOS Profile view.
│   └── Watch
│        ├── WatchContentView.swift    // Container for watchOS pages.
│        ├── WatchHomePage1View.swift    // Running clock, clock in/out, break button.
│        ├── WatchHomePage2View.swift    // Total time and break time.
│        ├── WatchHomePage3View.swift    // Earnings and goal completion.
│
└── MyApp.swift                 // iOS ContentView and App entry point.
└── MyApp_Watch.swift           // watchOS ContentView and App entry point.
```

## Installation and Setup

1. Clone the Repository:
   ```sh
   git clone https://github.com/yourusername/clockin-time-tracking-tool.git
   cd clockin-time-tracking-tool
   ```
2. Open the Project:
   - Open `Clockin.xcodeproj` in Xcode.
3. Set Up Shared Code:
   - Ensure Models and ViewModels have their target memberships set for both iOS and watchOS.
4. Build and Run:
   - Select the **iOS scheme** and run the app on the simulator or your device.
   - Select the **watchOS scheme** (e.g., "MyApp_Watch") to test on the watchOS Simulator.
5. (Optional) Seed Sample Data:
   - Open `Models/SampleData.swift` and call `seedSampleData()` in `ContentView.onAppear()` for testing.

## Usage

- **Clock In/Clock Out:**
  - On iOS, use the dashboard to clock in/out.
  - On watchOS, the first page shows a running clock with "Clock In/Out" and "Start/End Break" buttons.
- **Break Mode:**
  - "Start Break" pauses the work timer and begins tracking break time.
  - "End Break" resumes work time tracking.
- **Analytics:**
  - The app calculates total work time, break time, earnings (based on $15/hr), and goal completion in real time.
- **User Management:**
  - Sign up or log in using email.
  - In the Profile view, update the hourly rate and daily goal.
  - "Delete Account" allows re-sign-up with the same email.

## Future Improvements

- **Persistent Backend:**
  - Upgrade the in-memory database to Firebase or CloudKit for user data retention.
- **Enhanced Analytics:**
  - Add more detailed charts and trends visualization.
- **UI/UX Enhancements:**
  - Further refine watchOS and iOS interfaces for a polished look.

## Credits

Developed by **Rohan Waghmare**. Inspired by my own experiences as an international student balancing part-time work and academics. Special thanks to all those who believe in making every second count.

## License

[MIT License](LICENSE)
