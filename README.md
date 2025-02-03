# clockin
 
Below is a detailed README file in Markdown format for the “Clockin – A Time Tracking Tool” project. You can customize the content as needed.

Clockin – A Time Tracking Tool

Clockin is a cross‑platform time tracking solution built with Swift, SwiftUI, and WatchKit. It provides a robust clock‑in/clock‑out system with real‑time visual analytics for productivity and earnings. The app is designed for both iOS and watchOS, using a shared MVVM architecture to maintain consistent business logic across platforms.

Table of Contents
	•	Overview
	•	Features
	•	Technologies
	•	Architecture and Folder Structure
	•	Installation and Setup
	•	Usage
	•	Sample Data
	•	Future Improvements
	•	Credits
	•	License

Overview

Clockin is a time tracking tool developed out of my own experiences as an international student juggling academics and part‑time work. I noticed that every minute spent working was precious—and that the “earnings meter” running in our minds was a constant reminder of our dedication. With Clockin, users can seamlessly track their work time and breaks on both iOS and Apple Watch, view real‑time analytics (such as net work time, break time, and earnings), and stay motivated to “clock in and lock in” their productivity.

Features
	•	Cross‑Platform Support:
	•	iOS: A detailed dashboard showing work statistics, earnings, and goal completion.
	•	watchOS: A minimal, page‑based interface with three pages:
	•	Page 1: Running clock with Clock In/Out and Start/End Break buttons.
	•	Page 2: Total work time and break time.
	•	Page 3: Earnings and goal completion percentage.
	•	Real-Time Analytics:
	•	Dynamically calculates net work time (excluding break periods) and updates earnings live based on a default hourly rate of $15/hr and a daily goal of 6 hours.
	•	Uses a dedicated sessionWorkTime property to ensure that when on break, work time and earnings remain frozen.
	•	Intuitive UI:
	•	iOS interface leverages SwiftUI for an engaging, modern dashboard.
	•	Apple Watch interface uses a page‑based layout with simple navigation and clear visuals.
	•	Modular & Scalable Architecture:
	•	Implements an MVVM pattern with shared Models and ViewModels across iOS and watchOS.
	•	Uses an in‑memory database for prototyping with an option to seed sample data.
	•	Ready to be extended with a persistent backend (e.g., Firebase, CloudKit) for production.
	•	User Data Management:
	•	Each user’s data (time records, earnings, etc.) is stored separately.
	•	Includes functionality for account deletion so users can re‑sign‑up with the same email if needed.

Technologies
	•	Swift
	•	SwiftUI
	•	WatchKit
	•	MVVM Architecture

Architecture and Folder Structure

The project is organized using the MVVM pattern and shared between iOS and watchOS targets.

MyApp
│
├── Models
│   ├── DeviceModel.swift       // Contains the DeviceModel struct.
│   ├── UserRecord.swift        // Contains UserRecord and WorkDayRecord.
│   └── NumberFormatter+Extensions.swift   // Contains a NumberFormatter extension.
│   └── SampleData.swift        // (Optional) Seeds sample data.
│
├── ViewModels
│   ├── AuthViewModel.swift     // Contains AuthViewModel.
│   └── DevicesViewModel.swift  // Contains DevicesViewModel.
│
├── Views
│   ├── Authentication
│   │    ├── LoginView.swift    // iOS (and optionally watchOS) Login View.
│   │    └── SignUpView.swift   // iOS (and optionally watchOS) Sign Up View.
│   ├── Home
│   │    ├── HomeView.swift     // iOS Home Dashboard.
│   │    ├── MetricCardView.swift   // Part of iOS Home.
│   │    └── QuoteView.swift    // Contains sampleQuotes and QuoteView.
│   ├── Profile
│   │    └── ProfileView.swift  // iOS Profile view.
│   └── Watch
│        ├── WatchContentView.swift    // Container for watchOS pages.
│        ├── WatchHomePage1View.swift    // Running clock, clock in/out, break button.
│        ├── WatchHomePage2View.swift    // Total time and break time.
│        └── WatchHomePage3View.swift    // Earnings and goal completion.
│
└── MyApp.swift                 // iOS ContentView and App entry point.
└── MyApp_Watch.swift           // watchOS ContentView and App entry point.

Installation and Setup
	1.	Clone the Repository:

git clone https://github.com/yourusername/clockin-time-tracking-tool.git
cd clockin-time-tracking-tool


2.	Open the Project:
Open the Clockin.xcodeproj file in Xcode.
	3.	Set Up Shared Code:
Ensure that the Models and ViewModels files have their target memberships set for both the iOS and watchOS targets.
(Select each file, open the File Inspector, and check both targets under “Target Membership”.)
	4.	Build and Run:
	•	Select the iOS scheme and run the app on the simulator or your device.
	•	To test the watchOS version, select the watchOS scheme (e.g., “MyApp_Watch”) and run it on the watchOS Simulator.
	5.	(Optional) Seed Sample Data:
If you’d like to seed sample data for testing (for example, a super user with pre-populated work history), open Models/SampleData.swift, and call the function seedSampleData() in the onAppear of your ContentView (or elsewhere) for testing purposes.

Usage
	•	Clock In/Clock Out:
On the iOS app, use the dashboard to clock in and out. On watchOS, the first page shows a running clock with “Clock In/Out” and “Start/End Break” buttons.
	•	Break Mode:
Pressing “Start Break” disables the work timer (which then stops increasing) and begins updating break time only. When “End Break” is pressed, work time resumes.
	•	Analytics:
The app calculates total work time, break time, earnings (based on a default rate of $15/hr), and goal completion in real time.
	•	User Management:
Sign up or log in using your email. In the Profile view, you can update your hourly rate and daily goal. A “Delete Account” button lets you remove your user record so you can re‑sign‑up with the same email if needed.

Future Improvements
	•	Persistent Backend:
Upgrade the in‑memory database to a persistent backend (e.g., Firebase or CloudKit) to support thousands of users and retain data across app launches.
	•	Enhanced Analytics:
Add more detailed charts and analytics to visualize trends over time.
	•	UI/UX Enhancements:
Further refine the watchOS and iOS interfaces for a more polished look and enhanced usability.

Credits

Developed by Rohan Waghmare. Inspired by my own experiences as an international student balancing part‑time work and academics. Special thanks to all those who believe in making every second count.
