//
//  AppDelegate.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 29/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import Foundation
import UIKit
import AWSMobileClient
import IQKeyboardManagerSwift
import AWSCore
import AWSLex


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    // Add a AWSMobileClient call in application:didFinishLaunching
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // IQKeyBoard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        AWSDDLog.sharedInstance.logLevel = .info
        
        // LEX Data
        //replace the XXXXXs with your own id
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoRegionLex, identityPoolId: CognitoIdentityPoolIdLex)
        let configuration = AWSServiceConfiguration(region: LexRegionLex, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let chatConfig = AWSLexInteractionKitConfig.defaultInteractionKitConfig(withBotName: BotNameLex, botAlias: BotAliasLex)
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "AWSLexVoiceButton")
        chatConfig.autoPlayback = false
        AWSLexInteractionKit.register(with: configuration!, interactionKitConfiguration: chatConfig, forKey: "LamboBot")
        
        let syncClient = AWSCognito.default()
        let dataSet = syncClient.openOrCreateDataset("Preferences")
        let existingData = dataSet.getAllRecords()
        if existingData == nil {
            dataSet.setString("iOSApp", forKey: "Lambo")
            dataSet.synchronize().continueWith(block: { (task: AWSTask!) -> Any? in
                // Your code handle here
                print("U have to configue on IAM role")
                return nil
            })
        }else {
            print("Existing Data :-" ,existingData ?? [])
        }
        
        return AWSMobileClient.sharedInstance().interceptApplication(
            application, didFinishLaunchingWithOptions:
            launchOptions)
    }
    
    // Add a AWSMobileClient call in application:open url
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any) -> Bool {
        
        return AWSMobileClient.sharedInstance().interceptApplication(
            application, open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
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
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    }
    
}
