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
//    var auth: AWSCognitoAuth = AWSCognitoAuth.default()
//    var session: AWSCognitoAuthUserSession?
    
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
        
     //   pool.getUser("userpool")
    
    //    FBSDKSettings.setAppID("2323750814307850")
   //     [FBSDKSettings .setAppID("2323750814307850")]
        
//        FBSDKLoginButton.ema
//        user_vid
//        FBSDKSettings.
//        FBSDKLoginManager.ema
        
        let googleUser = AWSGoogleSignInProvider.sharedInstance().identityProviderName
        googleUser.description
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
        
        let button = FBSDKLoginButton()
        button.readPermissions = ["email","user_friends"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hjv()

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
        config.logoImage = UIImage(named: "google-icon")
        
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
    
//    func requestDidSucceed(apiResult: APIResult!) {
//        if apiResult.api == API.AuthorizeUser {
//            AIMobileLib.getAccessTokenForScopes(["profile"], withOverrideParams: nil, delegate: self)
//        } else if apiResult.api == API.GetAccessToken {
//            credentialsProvider.logins = [AWSCognitoLoginProviderKey.LoginWithAmazon.rawValue: apiResult.result]
//        }
//    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.web
        loginManager.logOut()
        print("logout successful")
        presentAuthUIViewController()
    }
    
    func abcd() {
        
        var credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: "us-east-1:b3fbc4dc-e2cc-4a83-b8c0-b3a9e4cc12b2")
        let configuration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let token = FBSDKAccessToken.current().tokenString
        print("token = ========", token!)
//        credentialsProvider.logins = [AWSCognitoLoginProviderKey.Facebook.rawValue: token]
//        credentialsProvider = AWSCognitoIdentityProvider.adminGetUser(credentialsProvider)
//        credentialsProvider.
        
    }
    
    func hjv() {
        
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
              //  self.userName = userName
                print("UserName Details :-", userName)
            }
            if let email = userResult.value(forKey: "email")  as? String {
                //  self.userName = userName
                print("Email Details :-", email)
            }
            if let id = userResult.value(forKey: "id")  as? String {
                //  self.userName = userName
                print("Id Details :-", id)
            }
            if let first_name = userResult.value(forKey: "first_name")  as? String {
                //  self.userName = userName
                print("first_name Details :-", first_name)
            }
            if let middle_name = userResult.value(forKey: "middle_name")  as? String {
                //  self.userName = userName
                print("middle_name Details :-", middle_name)
            }
            if let last_name = userResult.value(forKey: "last_name")  as? String {
                //  self.userName = userName
                print("last_name Details :-", last_name)
            }
            if let link = userResult.value(forKey: "link")  as? String {
                //  self.userName = userName
                print("link Details :-", link)
            }
//        //    let hjvhv = FBSDKProfile.current().userID
//        //    let hjvhv1 = FBSDKProfile.current().linkURL.description
//        //    let hjvhv2 = FBSDKProfile.current().refreshDate.description
//            let hjvhv3 = FBSDKProfile.current().name
//        //    print("FBSDKProfile.current().userID :-", hjvhv)
//        //    print("FBSDKProfile.current().linkURL :-", hjvhv1)
//        //    print("FBSDKProfile.current().refreshDate", hjvhv2)
//            print("FBSDKProfile.current().name :-", hjvhv3!)
        })
        userConnection.start()
        

    }

    @IBAction func logoutButtonT(_ sender: Any) {
        
//        let button = AWSCognitoIdentityProviderGlobalSignOutRequest.self
//        loginButtonDidLogOut(button)

        
//        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
//        {
//            let loginManager: FBSDKLoginManager = FBSDKLoginManager()
//            loginManager.loginBehavior = FBSDKLoginBehavior.web
//            loginManager.logOut()
//
//            print("logout successful")
//            presentAuthUIViewController()
//        }
//
        loginButtonDidLogOut(button)
        
//        self.auth.signOut { (error:Error?) in
//            if(error != nil){
//                self.alertWithTitle("Error", message: (error! as NSError).userInfo["error"] as? String)
//            }else {
//                self.session = nil
//                self.alertWithTitle("Info", message: "Session completed successfully")
//            }
//            self.refresh()
//        }

//        let config = AWSAuthUIConfiguration()
//
//        AWSAuthUIViewController.presentViewController(
//            with: self.navigationController!,
//            configuration: config, completionHandler: { (provider: AWSCognitoIdentityProviderGlobalSignOutRequest, error: Error?) in
//                if error == nil {
//                    // SignIn succeeded.
//                    print("Sign In succesfully")
//                    provider.logout()
//                    provider.reloadSession()
//                } else {
//                    // end user faced error while loggin in, take any required action here.
//                    print("Sign In failed")
//                }
//        })
//
////
//        UserDefaults.standard.removeObject(forKey: AWSFacebookSignInProviderKey)
//        if !(facebookLogin != nil) {
//            createFBSDKLoginManager()
//            print("logout successful")
//        }
//
//        facebookLogin?.logOut()
//        print("logout successful")

    }
    
//    func createFBSDKLoginManager() {
//        facebookLogin = FBSDKLoginManager()
//        facebookLogin?.loginBehavior = savedLoginBehavior!
//
//        let hjvhv = FBSDKProfile.current().userID
//        print(hjvhv)
//        FBSDKLoginBehavior.
//    }
    
//    func signOut() {
//        if username {
//            let keys = pool.keychain.keys as? [Any]
//            let keyChainPrefix = keyChainNamespaceClientId() + (".")
//            for key: String? in keys as? [String?] ?? [] {
//                //clear tokens associated with this user
//                if key?.hasPrefix(keyChainPrefix) ?? false {
//                    pool.keychain.removeItem(forKey: key)
//                }
//            }
//        }
//    }
    
 //   init(username: String?, pool: AWSCognitoIdentityUserPool?) {
//        super.init()
//
//        self.username = username
//        self.pool = pool
//        confirmedStatus = AWSCognitoIdentityUserStatusUnknown
//
//    }
    
//    func refresh () {
//        DispatchQueue.main.async {
//            self.title = self.session?.username;
//            print("Title :-", self.title as Any)
//            
//            print("Username :-", self.session?.username as Any)
//            print("accessToken :-", self.session?.accessToken?.tokenString as Any)
//            print("expirationTime :-", self.session?.expirationTime?.description as Any)
//            print("refreshToken :-", self.session?.refreshToken?.tokenString as Any)
//            print("idToken :-", self.session?.idToken?.tokenString as Any)
//            
//            print("Session :- ", self.session as Any)
//        }
//    }
    
}

