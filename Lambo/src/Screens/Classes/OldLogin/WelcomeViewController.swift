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
     //   AWSSignInButtonView.setSignInProvider(AWSFacebookSignInButton.)
        config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        let myColor = UIColor(red: 128.0 / 255.0, green: 90.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
        let v = GradientView()
        let hbhjkb = view.addSubview(v)
        
        let superAwesomeColor = UIColor()
////        self.view.backgroundColor = superAwesomeColor.convertHexStringToColor(hexString: "5C3299")
//        let beautifulGradient = UIColor()
//        let backGround = beautifulGradient.theGradientBackground(backgroundView: self.view, hexColor1: "eef2f3", hexColor2: "70e1f5")
//        let exquisiteGradient = UIColor()
//        config.backgroundColor = superAwesomeColor.convertHexStringToColor(hexString: "5C3299")
//   //     config.backgroundColor = exquisiteGradient.
        config.backgroundColor = superAwesomeColor.convertHexStringToColor(hexString: "5C3299")
        config.font = UIFont (name: "Loto-Medium", size: 20)
        config.isBackgroundColorFullScreen = true
        config.canCancel = true
//        if config.canCancel == true {
//            config.canCancel = UIColor.black.cgColor as! Bool
//        }
        
        config.logoImage = UIImage(named: "AppIcon1")
        config.logoImage?.accessibilityFrame = CGRect(x: -20, y: -20, width: (config.logoImage?.accessibilityFrame.size.width)! + 3000, height: (config.logoImage?.accessibilityFrame.size.height)! + 3000)
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                    print("Sign In succesfully")
//                    provider.reloadSession()
//                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                    let navVC = appDelegate?.window?.rootViewController as? UINavigationController
                    let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
                    let newViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                    //     navVC?.pushViewController(newViewController!, animated: true)
//                    newViewController?.getStartedbutton = getStartButton
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

extension WelcomeViewController {
    
//    private let gradient : CAGradientLayer = CAGradientLayer()
    
//    func setGradientBackground() -> UIColor {
//        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.view.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//        let myColor = UIColor(red: 128.0 / 255.0, green: 90.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
//        return UIColor.clear.cgColor
//    //    return gradientLayer.borderColor
//    }
//
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        let firstColor = UIColor(red: 130/255, green: 36/255, blue: 168/255, alpha: 1.0)
        let secondColor = UIColor(red: 89/255, green: 45/255, blue: 155/255, alpha: 1.0)
        
        let colours = [firstColor, secondColor]
        
        gradientLayer.colors = [firstColor, secondColor]
        
        self.view.layer.addSublayer(gradientLayer)
    }

}

extension UIView{
    
}


