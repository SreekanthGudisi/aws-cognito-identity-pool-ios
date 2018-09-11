//
//  ViewController.swift
//  L1
//
//  Created by Sreekanth Gudisi on 04/09/18.
//  Copyright © 2018 ai.lambo. All rights reserved.
//

import UIKit
import AWSAuthUI
import AWSMobileClient
import AWSUserPoolsSignIn
import AWSFacebookSignIn
import AWSGoogleSignIn
import AWSAuthCore
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

    private let AWSFacebookSignInProviderKey = "Facebook"
    var facebookLogin: FBSDKLoginManager?
    var savedLoginBehavior: FBSDKLoginBehavior?
    var pool = AWSCognitoIdentityUserPool.self
    var button : FBSDKLoginButton? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Get the identity Id from the AWSIdentityManager
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("AppDelegate Details", appDelegate)
        let credentialsProvider = AWSMobileClient.sharedInstance().getCredentialsProvider()
        print("CredentialsProvider Details", credentialsProvider)
        let identityId = AWSIdentityManager.default().identityId
        if identityId == nil{
            print("IdentityId Error")
        }else{
            print("IdentityId Details", identityId!)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserData()
    }
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = false
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.backgroundColor = UIColor.white
        config.font = UIFont (name: "Helvetica Neue", size: 20)
        config.isBackgroundColorFullScreen = true
        config.canCancel = true
//        config.logoImage = UIImage(named: "google-icon")
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                    print("Sign In succesfully")
                    provider.reloadSession()
//                    let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "SomeViewController") as? SomeViewController
//                    self.navigationController?.pushViewController(storyBoard!, animated: true)
                } else {
                    // end user faced error while loggin in, take any required action here.
                    print("Sign In failed")
                }
        })
    }

    func getUserData() {
        
        let imageGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "picture.type(large)"])
        let imageConnection = FBSDKGraphRequestConnection()
        imageConnection.add(imageGraphRequest, completionHandler: { (connection, result, error) in
            guard let imageResult = result as? NSDictionary else  { return}
            if let imageURL = URL(string:(((imageResult.value(forKey: "picture") as AnyObject).value(forKey: "data") as AnyObject).value(forKey: "url") as? String)!) {
             //   self.imageURL = imageURL
                print("ImageURL Details :-", imageURL)
            }
        })
        imageConnection.start()
        let userGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email,first_name, middle_name, last_name, link"])
        let userConnection = FBSDKGraphRequestConnection()
        userConnection.add(userGraphRequest, completionHandler: { (connection, result, error) in
            guard let userResult = result as? NSDictionary else { return }
            if let userName = userResult.value(forKey: "name")  as? String {
                print("UserName Details :-", userName)
            }
            if let email = userResult.value(forKey: "email")  as? String {
                print("Email Details :-", email)
            }
            if let id = userResult.value(forKey: "id")  as? String {
                print("Id Details :-", id)
            }
            if let first_name = userResult.value(forKey: "first_name")  as? String {
                print("first_name Details :-", first_name)
            }
            if let middle_name = userResult.value(forKey: "middle_name")  as? String {
                print("middle_name Details :-", middle_name)
            }
            if let last_name = userResult.value(forKey: "last_name")  as? String {
                print("last_name Details :-", last_name)
            }
            if let link = userResult.value(forKey: "link")  as? String {
                print("link Details :-", link)
            }
        })
        userConnection.start()
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.web
        loginManager.logOut()
        print("logout successful")
        presentAuthUIViewController()
    }
    
    @IBAction func logoutButtonT(_ sender: Any) {
        
        loginButtonDidLogOut(button)
    }
}

