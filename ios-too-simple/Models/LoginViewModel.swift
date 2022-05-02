//
//  LoginViewModel.swift
//  ios-too-simple
//
//  Created by Brandon Lempka on 4/8/22.
//

import Foundation
import JWTDecode

class LoginViewModel: ObservableObject {
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        let defaults = UserDefaults.standard
        let jwt = defaults.string(forKey: "jwt")
        
        if jwt == nil {
            isAuthenticated = false
        } else {
            do {
                let jwt = try decode(jwt: jwt!)
                if (jwt.expired) {
                    errorMessage = "Login expired. Please sign in again."
                    isAuthenticated = false
                } else {
                    isAuthenticated = true
                }
            }
            catch let parseError {
                print(parseError)
            }
            
        }
    }
    
    func login() {
    let defaults = UserDefaults.standard
        
        AuthService().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                if token.success ?? false {
                    defaults.setValue(token.bearerToken, forKey: "jwt")

                    do {
                        let jwt = try decode(jwt: token.bearerToken!)
                            //print(jwt)
                            //print(jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"))
                            defaults.setValue(
                                jwt.claim(name: "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier").rawValue,
                                forKey: "userId")
                    }
                    catch let parseError {
                        print(parseError)
                    }
                    
                    DispatchQueue.main.async { self.isAuthenticated = true }
                    DispatchQueue.main.async { self.errorMessage = "" }
                    
                } else {
                    print(token.errorMessage ?? "")
                    DispatchQueue.main.async { self.errorMessage = token.errorMessage ?? "" }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout() {
        let defaults = UserDefaults.standard

        defaults.removeObject(forKey: "jwt")
        DispatchQueue.main.async { self.isAuthenticated = false }
    }
}
