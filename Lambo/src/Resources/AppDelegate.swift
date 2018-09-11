//
//  AppDelegate.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 29/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import AWSLex
import IQKeyboardManagerSwift
import GoogleSignIn
import AWSGoogleSignIn
import AWSFacebookSignIn
import AWSCognitoAuth
import AWSMobileClient


//import AWSCognitoIdentityProvider
//import AWSCore
//import AWSCognito
//import AWSLex
//import IQKeyboardManagerSwift
//import AWSMobileClient
//import AWSFacebookSignIn
//import AWSUserPoolsSignIn
//import AWSAuthCore
//import AWSAuthUI
//import GoogleSignIn
//
//import AWSAuthCore
//import AWSAuthUI
//import AWSMobileClient


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let userId = user?.userID // For client-side use only!
        print(userId as Any)
        let idToken = user?.authentication.idToken // Safe to send to the server
        print(idToken as Any)
        let fullName = user?.profile.name
        print(fullName as Any)
        let givenName = user?.profile.givenName
        print(givenName as Any)
        let familyName = user?.profile.familyName
        print(familyName as Any)
        let email = user?.profile.email
        print(email as Any)
        // ...
    }
    
    
    var window: UIWindow?
    var signInViewController: SignInViewController?
    var mfaViewController: MFAViewController?
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//
////        // IQKeyBoard Manager
////        IQKeyboardManager.shared.enable = true
////        IQKeyboardManager.shared.enableAutoToolbar = true
//////        Fabric.with([Crashlytics.self])
////
////        // Warn user if configuration not updated
////        if (CognitoIdentityUserPoolId == "ap-south-1_R17tMtrIF") {
////            let alertController = UIAlertController(title: "Invalid Configuration",
////                                                    message: "Please configure user pool constants in Constants.swift file.",
////                                                    preferredStyle: .alert)
////            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
////            alertController.addAction(okAction)
////
////            self.window?.rootViewController!.present(alertController, animated: true, completion:  nil)
////        }
////        // setup logging
////        AWSDDLog.sharedInstance.logLevel = .verbose
////        // setup service configuration
////        let serviceConfiguration = AWSServiceConfiguration(region: CognitoIdentityUserPoolRegion, credentialsProvider: nil)
////        // create pool configuration
////        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoIdentityUserPoolAppClientId,
////                                                                        clientSecret: CognitoIdentityUserPoolAppClientSecret,
////                                                                        poolId: CognitoIdentityUserPoolId)
////        // initialize user pool client
////        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: AWSCognitoUserPoolsSignInProviderKey)
////        // fetch the user pool client we initialized in above step
////        let pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
////        self.storyboard = UIStoryboard(name: "LoginAndRegister", bundle: nil)
////        pool.delegate = self
////
////        // LEX Data
//////        //replace the XXXXXs with your own id
//////        let credentialProvider = AWSCognitoCredentialsProvider(regionType: CognitoRegionLex, identityPoolId: CognitoIdentityPoolIdLex)
//////        let configuration = AWSServiceConfiguration(region: LexRegionLex, credentialsProvider: credentialProvider)
//////        AWSServiceManager.default().defaultServiceConfiguration = configuration
//////        //change "botBot" to the name of your Lex bot
//////        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: BotNameLex, botAlias: BotAliasLex)
//////        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
////
////        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoRegionLex, identityPoolId: CognitoIdentityPoolIdLex)
////        let configuration = AWSServiceConfiguration(region: LexRegionLex, credentialsProvider: credentialsProvider)
////        AWSServiceManager.default().defaultServiceConfiguration = configuration
////        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: BotNameLex, botAlias: BotAliasLex)
////        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "AWSLexVoiceButton")
////        chatConfig.autoPlayback = false
////        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
//
//        return AWSMobileClient.sharedInstance().interceptApplication(
//            application, open: url,
//            sourceApplication: sourceApplication,
//            annotation: annotation)
//
//        return true
//    }
    
    // Add a AWSMobileClient call in application:didFinishLaunching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // IQKeyBoard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        AWSDDLog.sharedInstance.logLevel = .info
        print("Aws Details AWSDDLogLevel", AWSDDLog.sharedInstance.logLevel)
        
        //Google SignIn
        GIDSignIn.sharedInstance().clientID = "YOUR_CLIENT_ID"
        GIDSignIn.sharedInstance().delegate = self

        
        // LEX Data
        //replace the XXXXXs with your own id
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: CognitoRegionLex, identityPoolId: CognitoIdentityPoolIdLex)
        let configuration = AWSServiceConfiguration(region: LexRegionLex, credentialsProvider: credentialProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        //change "botBot" to the name of your Lex bot
        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: BotNameLex, botAlias: BotAliasLex)
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "chatConfig")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Create AWSMobileClient to connect with AWS
        return AWSMobileClient.sharedInstance().interceptApplication(
            application,
            didFinishLaunchingWithOptions: launchOptions)
        //    return true
    }
    
    // Add a AWSMobileClient call in application:open url
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any) -> Bool {
        
        GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
        return AWSMobileClient.sharedInstance().interceptApplication(
            application, open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled : Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        // Add any custom logic here.
        
        let handle : Bool = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
 //       return AWSCognitoAuth.default().application(application, open: url, options: options)get
        return handled 
    }

    func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?) throws {
        // Perform any operations on signed in user here.
        let userId = user?.userID // For client-side use only!
        print(userId as Any)
        let idToken = user?.authentication.idToken // Safe to send to the server
        print(idToken as Any)
        let fullName = user?.profile.name
        print(fullName as Any)
        let givenName = user?.profile.givenName
        print(givenName as Any)
        let familyName = user?.profile.familyName
        print(familyName as Any)
        let email = user?.profile.email
        print(email as Any)
        // ...
    }
    
    func sign(_ signIn: GIDSignIn?, didDisconnectWith user: GIDGoogleUser?) throws {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    }
    
}
//
//// MARK:- AWSCognitoIdentityInteractiveAuthenticationDelegate protocol delegate
//extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
//
//    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
//        if (self.navigationController == nil) {
//            self.navigationController = self.storyboard?.instantiateViewController(withIdentifier: "signInController") as? UINavigationController
//        }
//
//        if (self.signInViewController == nil) {
//            self.signInViewController = self.navigationController?.viewControllers[0] as? SignInViewController
//        }
//
//        DispatchQueue.main.async {
//            self.navigationController!.popToRootViewController(animated: true)
//            if (!self.navigationController!.isViewLoaded
//                || self.navigationController!.view.window == nil) {
//                self.window?.rootViewController?.present(self.navigationController!,
//                                                         animated: true,
//                                                         completion: nil)
//            }
//
//        }
//        return self.signInViewController!
//    }
//
//    func startMultiFactorAuthentication() -> AWSCognitoIdentityMultiFactorAuthentication {
//        if (self.mfaViewController == nil) {
//            self.mfaViewController = MFAViewController()
//            self.mfaViewController?.modalPresentationStyle = .popover
//        }
//        DispatchQueue.main.async {
//            if (!self.mfaViewController!.isViewLoaded
//                || self.mfaViewController!.view.window == nil) {
//                //display mfa as popover on current view controller
//                let viewController = self.window?.rootViewController!
//                viewController?.present(self.mfaViewController!,
//                                        animated: true,
//                                        completion: nil)
//
//                // configure popover vc
//                let presentationController = self.mfaViewController!.popoverPresentationController
//                presentationController?.permittedArrowDirections = UIPopoverArrowDirection.left
//                presentationController?.sourceView = viewController!.view
//                presentationController?.sourceRect = viewController!.view.bounds
//            }
//        }
//        return self.mfaViewController!
//    }
//
//    func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
//        return self
//    }
//}
//
//// MARK:- AWSCognitoIdentityRememberDevice protocol delegate
//
//extension AppDelegate: AWSCognitoIdentityRememberDevice {
//
//    func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
//        self.rememberDeviceCompletionSource = rememberDeviceCompletionSource
//        DispatchQueue.main.async {
//            // dismiss the view controller being present before asking to remember device
//            self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
//            let alertController = UIAlertController(title: "Remember Device",
//                                                    message: "Do you want to remember this device?.",
//                                                    preferredStyle: .actionSheet)
//
//            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                self.rememberDeviceCompletionSource?.set(result: true)
//            })
//            let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
//                self.rememberDeviceCompletionSource?.set(result: false)
//            })
//            alertController.addAction(yesAction)
//            alertController.addAction(noAction)
//
//            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//    func didCompleteStepWithError(_ error: Error?) {
//        DispatchQueue.main.async {
//            if let error = error as NSError? {
//                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
//                                                        message: error.userInfo["message"] as? String,
//                                                        preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
//                alertController.addAction(okAction)
//                DispatchQueue.main.async {
//                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
//}
//
//
