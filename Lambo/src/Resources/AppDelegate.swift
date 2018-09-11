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
    var navigationController: UINavigationController?
    var storyboard: UIStoryboard?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?

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
        GIDSignIn.sharedInstance().clientID = "572800502237-bqhk8qj0hhv8vh14rfmrogfpqi5nrca4.apps.googleusercontent.com"
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
        
        let handleFacebook : Bool = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        let handleGoogle : Bool = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
 //       return AWSCognitoAuth.default().application(application, open: url, options: options)get
        return handleFacebook
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
