//
//  SachinViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 22/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit
import AWSAuthUI
import AWSMobileClient
import AWSUserPoolsSignIn
import AWSFacebookSignIn
import AWSAuthCore


class SachinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        //Need to let CognitoAuth handle redirects so it can extract tokens
//        func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//            return AWSCognitoAuth.default().application(app, open: url, options: options)
//        }
        
//        // Do any additional setup after loading the view.
//        if !AWSSignInManager.sharedInstance().isLoggedIn {
//            presentAuthUIViewController()
//        }
        
        
        singIn()
    }

//    func presentAuthUIViewController() {
//        let config = AWSAuthUIConfiguration()
//        config.enableUserPoolsUI = true
//        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
//        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
//        config.backgroundColor = UIColor.blue
//        config.font = UIFont (name: "Helvetica Neue", size: 20)
//        config.isBackgroundColorFullScreen = true
//        config.canCancel = false
//        
//        AWSAuthUIViewController.presentViewController(
//            with: self.navigationController!,
//            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
//                if error == nil {
//                    // SignIn succeeded.
//                } else {
//                    // end user faced error while loggin in, take any required action here.
//                }
//        })
//    }
}

extension SachinViewController {
    
    func singIn() {
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController
                .presentViewController(with: self.navigationController!,
                                       configuration: nil,
                                       completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                        if error != nil {
                                            print("Error occurred: \(String(describing: error))")
                                        } else {
                                            // Sign in successful.
                                        }
                })
        }
    }
    
    func signOut() {
        
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            self.singIn()
            // print("Sign-out Successful: \(signInProvider.getDisplayName)");
            
        })
    }

}
