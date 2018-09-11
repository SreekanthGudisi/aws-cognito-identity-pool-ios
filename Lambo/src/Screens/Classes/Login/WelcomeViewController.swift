//
//  WelcomeViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 23/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import Foundation
import UIKit
import AWSAuthUI
import AWSMobileClient
import AWSUserPoolsSignIn
import AWSFacebookSignIn
import AWSGoogleSignIn
import AWSAuthCore
import FBSDKLoginKit
import FBSDKCoreKit

class WelcomeViewController: UIViewController{

    private let gradient : CAGradientLayer = CAGradientLayer()
    var gradientLayer: CAGradientLayer!
    
    var homeviewController : HomeViewController? = nil
    var isSelect = false
    var firstLoad: Bool = false
    
    @IBOutlet weak var getStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        isSelect = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = false
        config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        let superAwesomeColor = UIColor()
        config.backgroundColor = superAwesomeColor.convertHexStringToColor(hexString: "5C3299")
        config.font = UIFont (name: "Loto-Medium", size: 20)
        config.isBackgroundColorFullScreen = true
        config.canCancel = true
        config.logoImage = UIImage(named: "AppIcon1")
        config.logoImage?.accessibilityFrame = CGRect(x: -20, y: -20, width: (config.logoImage?.accessibilityFrame.size.width)! + 3000, height: (config.logoImage?.accessibilityFrame.size.height)! + 3000)
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                    print("Sign In succesfully")
//                    provider.reloadSession()
                    let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                    let newViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                    self.navigationController?.pushViewController(newViewController!, animated: true)
                } else {
                    // end user faced error while loggin in, take any required action here.
                    print("Sign In failed")
                }
        })
    }
    
    @IBAction func getStartButtonTapped(_ sender: Any){
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
    }
}

