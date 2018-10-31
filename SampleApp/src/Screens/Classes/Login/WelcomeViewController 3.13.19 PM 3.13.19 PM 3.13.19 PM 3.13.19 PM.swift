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
import AWSLex
import AWSCognito

class WelcomeViewController: UIViewController{
    
    private let gradient : CAGradientLayer = CAGradientLayer()
    var gradientLayer: CAGradientLayer!
    
    var homeviewController : HomeViewController? = nil
    var isSelect = false
    var firstLoad: Bool = false
    var aWSIdentityProvider : AWSIdentityProvider? = nil
    
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
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                    print("Sign In succesfully")
                    print("provider.identityProviderName :-", provider.identityProviderName)
                    print("provider.identityProviderName.token()", provider.token())
                    print("provider.identityProviderName.token().result", provider.token().result as Any)
                    provider.reloadSession()
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
        }else{
            let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            self.navigationController?.pushViewController(newViewController!, animated: true)
        }
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 100), 0) / 100
        switch percentage {
        case 0: return self
        case 1: return color
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
            guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }
            
            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
}




