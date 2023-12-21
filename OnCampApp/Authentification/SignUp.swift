//
//  SignUp.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct SignUp: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel = AuthViewModel()
    
    @State private var email: String = ""
    @State private var uid: String = ""
    @State private var password: String = ""
    @State private var confirmedpassword: String = ""
    @State private var signUpSuccesful: Bool = false
    
    var body: some View {
        if signUpSuccesful{
            CreateAccount(uid: self.uid)
        } else {
            content
        }
    }
    
    
    var content: some View {
        NavigationView {
            VStack {
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 120)
                    .padding()
                HStack {
                    Text("Sign")
                        .foregroundColor(Color.blue)
                        .padding(.trailing, -5.0)
                    Text("Up!")
                    
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                Spacer()
                VStack {
                    TextField("Email", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    SecureField("Password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    SecureField("Confirm Password", text: $confirmedpassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    
                }
                
                Spacer()
                Button(action: {
                    if password == confirmedpassword {
                        SignUp()
                    }else{
                    
                        print("signup failed" )
                    }
                    
                }) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .cornerRadius(8)
                        .background(.blue)
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink(destination: SignIn()) {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color("LTBL"))
                    .font(.footnote)
                }
                .padding(.vertical, 16)
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        if user != nil {
                            guard let currentUser = Auth.auth().currentUser else {
                                // Handle error
                                print ("error getting current user")
                                return
                            }
                            self.uid = currentUser.uid
                            signUpSuccesful.toggle()
                            print ("uid is ", self.uid)
                        }
                    }
                }
            }
        }
    }
    func SignUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle signup error
                print("Signup error: \(error)")
            } else {
                guard let currentUser = Auth.auth().currentUser else {
                    // Handle error
                    print("Error getting current user")
                    return
                }
                self.uid = currentUser.uid
                print("User UID: \(self.uid)")
            }
        }
    }
}


struct SignUpView: PreviewProvider {
    static var previews: some View {
        Group{
            SignUp()
                .preferredColorScheme(.light)
            SignUp()
                .preferredColorScheme(.dark)
        }
    }
}
