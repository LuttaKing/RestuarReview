//
//  ContentView.swift
//  RestuarReview
//
//  Created by Denilson Washuma on 29/06/2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    
    @State private var email:String = ""
    @State private var password:String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    //Textfield focus shii
    enum Field {
        case emailField, passwordField
    }
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                Image(systemName: "car")
                    
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
                
                Text("RestuReview")
                    .font(.title.bold())
                    .foregroundStyle(.orange.gradient)
                
                Group{
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .focused($focusField,equals: .emailField)
                        .submitLabel(.next) //go to next field on press
                        .onSubmit {
                            focusField = .passwordField //go to next
                        }
                    
                    
                    SecureField("Pass", text: $password)
                        .focused($focusField,equals: .passwordField)
                        .submitLabel(.done)
                        .onSubmit {
                            focusField = nil //dismiss keyboard
                        }
                }
                
                .textFieldStyle(.roundedBorder)
                .padding(.bottom,10)
                
                HStack(spacing:50){
                    Button(action: {
                        loginUser()
                        
                    }, label: {
                        Text("Log In")
                    })
                    
                    Button(action: {
                        registerUser()
                        
                    }, label: {
                        Text("Sign Up")
                    })
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .font(.title)
                .padding(.top)
                
                Spacer()
                
            }
            .padding()
          
        
        }
        .alert(alertMessage,isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func registerUser(){
        
        guard validateInputData() else{
            alertMessage = "Use a valid email or password"
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Register Error: \(error.localizedDescription)")
                alertMessage = "Register Error: \(error.localizedDescription)"
                showAlert = true
            } else {
                print("Register success")
            }
        }
    }
    
    func loginUser(){
        guard validateInputData() else{
            alertMessage = "Use a valid email or password"
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showAlert = true
            } else {
                print("Login success")
            }
        }
        
    }
    
    func validateInputData() -> Bool {
        return email.count > 10 && password.count > 6
       
    }
}

#Preview {
    LoginView()
}
