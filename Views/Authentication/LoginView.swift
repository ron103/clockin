
// Views/Authentication/LoginView.swift
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        GeometricPatternView()
                            .frame(height: 250)
                        VStack(spacing: 10) {
                            Image("LogoW")
                                .resizable()
                                .renderingMode(.template)
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
                    Spacer()
                    VStack(spacing: 20) {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        TextField("example@gmail.com", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        Button(action: {
                            DispatchQueue.main.async {
                                auth.signIn(email: email, password: password)
                            }
                        }) {
                            Text("Login")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Don't have any account? Sign Up")
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
            .alert("Login Error", isPresented: Binding<Bool>(
                get: { auth.loginError != nil },
                set: { _, _ in auth.loginError = nil }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(auth.loginError ?? "")
            }
        }
    }
}
