//
//  LoginView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/12/22.
//

import SwiftUI

struct LoginView: View {
    @State var loginVM: LoginViewModel
    @FocusState var passwordFocused: Bool
    
    var body: some View {
        VStack {
            Image("TooSimpleLogo")
                .resizable()
                .frame(width: 260, height: 160, alignment: .center)
                .padding(.top, 100)
            
            
            Spacer()
            
            Form {
                TextField("Email", text: $loginVM.username)
                    .keyboardType(.emailAddress)
                    .onSubmit {
                        passwordFocused = true
                    }
                
                SecureField("Password", text: $loginVM.password)
                    .focused($passwordFocused)
                    .onSubmit {
                        loginVM.login()
                    }
                HStack {
                    Spacer()
                    
                    Button(action: loginVM.login) {
                        Text("Login")
                            .multilineTextAlignment(.center)
                            .frame(width: 220, height: 25, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(Color("TooSimplePurple"))
                    .padding()
                    //.disabled(loginVM.username.isEmpty || loginVM.password.isEmpty)
                    
                    Spacer()
                }
                
                if (loginVM.errorMessage.count > 1) {
                    
                    Text(loginVM.errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
            .preferredColorScheme(.dark)
    }
}
