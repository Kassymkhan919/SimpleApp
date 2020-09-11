//
//  AuthViewController.swift
//  SimpleApp
//
//  Created by dev on 9/3/20.
//  Copyright © 2020 dev. All rights reserved.
//
import Firebase
import UIKit
import AuthenticationServices

extension AuthViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // return the current view window
        return self.view.window!
    }
}

extension AuthViewController : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential  {
            // unique ID for the user
            let userID = appleIDCredential.user
          
            // save it to user defaults
            UserDefaults.standard.set(appleIDCredential.user, forKey: "userID")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }

        switch error.code {
        case .canceled:
            // user press "cancel" during the login prompt
            print("Canceled")
        case .unknown:
            // user didn't login their Apple ID on the device
            print("Unknown")
        case .invalidResponse:
            // invalid response received from the login
            print("Invalid Respone")
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            print("Not handled")
        case .failed:
            // authorization failed
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            // use the user credential / data to do stuff here ...
//        }
//    }
}

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let siwaButton = ASAuthorizationAppleIDButton()

           // set this so the button will use auto layout constraint
           siwaButton.translatesAutoresizingMaskIntoConstraints = false

           // add the button to the view controller root view
           self.view.addSubview(siwaButton)

           // set constraint
           NSLayoutConstraint.activate([
               siwaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
               siwaButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
               siwaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0),
               siwaButton.heightAnchor.constraint(equalToConstant: 50.0)
           ])

           // the function that will be executed when user tap the button
           siwaButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
        
        
         if let userID = UserDefaults.standard.string(forKey: "userID") {
                    
            // get the login status of Apple sign in for the app
            // asynchronous
            ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userID, completion: {
                credentialState, error in

                switch(credentialState){
                case .authorized:
                    print("user remain logged in, proceed to another view")
                    self.performSegue(withIdentifier: "LoginToUserSegue", sender: nil)
                case .revoked:
                    print("user logged in before but revoked")
                case .notFound:
                    print("user haven't log in before")
                default:
                    print("unknown state")
                }
            })
        }

    }
    
    // this is the function that will be executed when user tap the button
    @objc func appleSignInTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.presentationContextProvider = self
        authController.delegate = self
        authController.performRequests()
        
    }
    
    
}
