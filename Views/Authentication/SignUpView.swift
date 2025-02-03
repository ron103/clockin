
// Views/Authentication/SignUpView.swift
import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: AuthViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var showError: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    GeometricPatternView()
                        .frame(height: 250)
                    VStack(spacing: 10) {
                        Image("Logo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("Unleash Your Productivity")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("example@gmail.com", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button(action: {
                        DispatchQueue.main.async {
                            if validateSignUp() {
                                auth.signUp(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Already have an account? Sign In")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
        .alert("Error", isPresented: Binding<Bool>(
            get: { showError },
            set: { _, _ in showError = false }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Unknown error")
        }
    }
    
    private func validateSignUp() -> Bool {
        if firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "All fields are required."
            showError = true
            return false
        }
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            showError = true
            return false
        }
        if !isValidPassword(password) {
            errorMessage = "Password must be at least 6 characters long and include at least 1 number and 1 symbol."
            showError = true
            return false
        }
        return true
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        if password.count < 6 { return false }
        let numberRegEx = ".*[0-9]+.*"
        let symbolRegEx = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let symbolTest = NSPredicate(format:"SELF MATCHES %@", symbolRegEx)
        return numberTest.evaluate(with: password) && symbolTest.evaluate(with: password)
    }
}
