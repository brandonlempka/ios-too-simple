//
//  LoginView.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/12/22.
//

import SwiftUI

struct LoginView: View {
    @State var loginVM: LoginViewModel
    
    var body: some View {
        VStack {
            Form {
            TextField("Username", text: $loginVM.username)
            SecureField("Password", text: $loginVM.password)
                Button(action: loginVM.login) {
                    Text("Login")
                        .frame(width: 260)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(Color("TooSimplePurple"))
                .padding()
                
                if (loginVM.errorMessage.count > 1) {
                    
                    Text(loginVM.errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(false)
//    }
//}
