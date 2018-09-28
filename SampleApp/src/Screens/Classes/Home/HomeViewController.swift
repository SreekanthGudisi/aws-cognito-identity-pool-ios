//
//  HomeViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 21/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import AWSAuthUI
import AWSMobileClient
import AWSUserPoolsSignIn
import AWSFacebookSignIn
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import AWSGoogleSignIn
import Foundation
import AWSAuthCore
import AWSAuthUI
import AWSMobileClient
import CoreGraphics

class HomeViewController: UIViewController{
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var firstLoad: Bool = true
    var nbhnb : AWSSignInProvider?
    var bvv : AWSCognitoIdentity?
    
    var aWSCognitoIdentityGetOpenIdTokenResponse : AWSCognitoIdentityGetOpenIdTokenResponse?
    var aWSCredentialsProvider : AWSCredentialsProvider?
    var AWSXMLDictionaryParser : XMLParserDelegate?
    
    var signInProvider : AWSSignInProvider? = nil
    var getStartedbutton : UIButton!
    
    var menuItems = ["Home", "Profile", "Transaction History", "Past amount", "AWS Sign Out"];

    var credentialsProvider: AWSCognitoCredentialsProvider?
    var completionHandler: AWSIdentityManagerCompletionBlock?
    weak var currentSignInProvider: AWSSignInProvider?
    weak var lastSignInProvider: AWSSignInProvider?
    let AWSIdentityManagerDidSignInNotification = "com.amazonaws.AWSIdentityManager.AWSIdentityManagerDidSignInNotification"
    let AWSIdentityManagerDidSignOutNotification = "com.amazonaws.AWSIdentityManager.AWSIdentityManagerDidSignOutNotification"
    let AWSIdentityManagerUserDefaultsProvidersOk = "com.amazonaws.AWSIdentityManager.ProvidersOk"
    typealias AWSIdentityManagerCompletionBlock = (Any?, Error?) -> Void
    var loginCache: [String : String] = [:] // Be a "real" AWSIdentityProviderManager
    private let AWSInfoIdentityManager = "IdentityManager"
    
    var aWSCognitoCredentialsProviderHelper : AWSCognitoCredentialsProviderHelper?
    
    @IBOutlet var sideViewLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var hamburgerMenuTopContraint: NSLayoutConstraint!
    
    @IBOutlet weak var hamburgerMenu: UIView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var viewControllersUIView: UIView!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileNameButton: UIButton!
    @IBOutlet weak var tableview: UITableView!

    
    var isSelect = false
    var isChatSelect = false
    var isWalletSelect = false
    var isProfileSelect = false
    
    var chatViewController: ChatViewController? = nil
    var walletViewController: WalletViewController? = nil
    var profileViewController: ProfileViewController? = nil
    
    var chatBlueImage = UIImage()
    var chatImage = UIImage()
    var walletBlueImage = UIImage()
    var walletImage = UIImage()
    var profileBlueImage = UIImage()
    var profileImage = UIImage()
    
    var label = UILabel()
    
    var logoutbutton : FBSDKLoginButton? = nil
    
    var fristName = String()
    var lastName = String()
    var profileName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isSelect = true
        isChatSelect = true
        isWalletSelect = true
        isProfileSelect = true
        
        self.navigationController?.navigationBar.isHidden = true
        
        getGoogleUserData()
        getFacebookUserData()
        
        print("pool?.getUser().username :-", pool?.currentUser()?.username as Any)
        print("pool?.getUser().username :-", pool?.currentUser()?.deviceId as Any)
        print("pool?.getUser().username :-", pool?.identityProviderName as Any)
        print("pool?.getUser().username :-", pool?.getUser().deviceId as Any)
        
        if UIDevice.current.isPhoneX() {
            hamburgerMenuTopContraint.constant = 40
        } else {
            //hamburgerMenuTopContraint.constant = 28
        }
        
        sideViewLeadingSpace.constant = -275
        hideButton.isHidden = true
        images()
        greetingMessage()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionLabel.center = CGPoint(x: self.chatButton.center.x, y: self.selectionLabel.center.y)
        }) { (isCompleted) in
            self.isChatSelect = true
            self.chatviewController()
        }
        
        
        let identityManager = AWSIdentityManager.default().credentialsProvider
        print("IdentityManager.IdentityId :- ", identityManager.identityId as Any)
        print("IdentityManager.identityPoolId :- ",identityManager.identityPoolId)
        //   print(identityManager.identityProvider.)
        
        self.pool = AWSCognitoIdentityUserPool(forKey: CognitoIdentityPoolIdLex)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
            print("self.user :- ", self.user as Any)
        }
        self.refresh()
        
        print("response :-", response?.userAttributes as Any)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        sideView.layer.shadowOpacity = 0
        sideView.layer.shadowRadius = 0
        hideButton.isHidden = true
        UIView.animate(withDuration: 0.0, animations: {
            self.sideViewLeadingSpace.constant = -275
            self.view.layoutIfNeeded()
        })
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        hamburgerMenu.setNeedsLayout()
        hamburgerMenu.setNeedsDisplay()
    }

    private func greetingMessage() {
        //greeting
        let now = NSDate()
        let cal = NSCalendar.current
        let hour = cal.component(.hour, from: now as Date)
        switch hour {
        case 0 ... 12:
            welcomeLabel.text = "Hi, Good Morning"
        case 13 ... 17:
            welcomeLabel.text = "Hi, Good Afternoon"
        default:
            welcomeLabel.text = "Hi, Good Evening"
        }
    }
    
    func getViewController() -> UIViewController {
        return self;
    }

    //MARK: - IBActions
    @IBAction func chatButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionLabel.center = CGPoint(x: self.chatButton.center.x, y: self.selectionLabel.center.y)
        }) { (isCompleted) in
            self.chatviewController()
        }
    }
    @IBAction func walletButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionLabel.center = CGPoint(x: self.walletButton.center.x, y: self.selectionLabel.center.y)
        }) { (isCompleted) in
            self.walletviewControoler()
        }
    }
    @IBAction func profileButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.selectionLabel.center = CGPoint(x: self.profileButton.center.x, y: self.selectionLabel.center.y)
        }) { (isCompleted) in
            self.profileviewControoler()
        }
    }

    @IBAction func hamburgerButtonTapped(_ sender: Any) {
        // hide/unhide the menu view
        isSelect = true
        sideView.layer.shadowOpacity = 1
        sideView.layer.shadowRadius = 4
        hideButton.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.sideViewLeadingSpace.constant = 0
            self.view.layoutIfNeeded()
        })
        isSelect = false
    }
    
    @IBAction func hideButtonTapped(_ sender: Any) {
        isSelect = true
        sideView.layer.shadowOpacity = 0
        sideView.layer.shadowRadius = 0
        hideButton.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.sideViewLeadingSpace.constant = -275
            self.view.layoutIfNeeded()
        })
        isSelect = false
    }
}


// MARK :- Functions
extension HomeViewController {
    
    private func images(){
        chatBlueImage = UIImage(named: "chatImage")!
        chatImage = UIImage(named: "chatImage1")!
        walletBlueImage = UIImage(named: "walletImage")!
        walletImage = UIImage(named: "walletImage1")!
        profileBlueImage = UIImage(named: "profileImage")!
        profileImage = UIImage(named: "profileImage1")!
    }
    
    func logOutFromAWS() {
        
        let hjh1 = self.signInProvider?.identityProviderName
        print("signInProvider?.identityProviderName :-", hjh1 as Any)
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            //   print("Sign-out Successful: \(String(describing: self.signInProvider?.reloadSession()))");
            print("Sign-out Successful: \(String(describing: self.signInProvider))")
            self.signInProvider?.logout()
            self.signInProvider?.reloadSession()
            self.signInProvider?.token()
            //            self.lastSignInProvider.
            
            //    self.wipeAll()
            let hjh = self.signInProvider?.identityProviderName
            print("signInProvider?.identityProviderName :-", hjh as Any)
            let controllers = self.navigationController?.viewControllers
            for vc in controllers! {
                if vc is WelcomeViewController {
                    self.navigationController?.popToViewController(vc as! WelcomeViewController, animated: true)
                }
            }
        })
    }
    
}
extension HomeViewController {
    
    func chatviewController() {
        
        isChatSelect = true
        isWalletSelect = false
        isProfileSelect = false
        if isChatSelect == true {
            chatButton.setBackgroundImage(chatBlueImage, for: .normal)
            walletButton.setBackgroundImage(walletImage, for: .normal)
            profileButton.setBackgroundImage(profileImage, for: .normal)
        }
        if (chatViewController == nil) {
            let vc = UIStoryboard(name: "ChatPool", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            chatViewController = vc
        }
        var frame = viewControllersUIView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        viewControllersUIView.addSubview((chatViewController?.view)!)
    }
    
    func walletviewControoler() {
        
        isChatSelect = false
        isWalletSelect = true
        isProfileSelect = false
        
        if isWalletSelect == true {
            chatButton.setBackgroundImage(chatImage, for: .normal)
            walletButton.setBackgroundImage(walletBlueImage, for: .normal)
            profileButton.setBackgroundImage(profileImage, for: .normal)
        }
        if (walletViewController == nil) {
            let vc = UIStoryboard(name: "Wallet", bundle: nil).instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
            walletViewController = vc
        }
        var frame = viewControllersUIView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        viewControllersUIView.addSubview((walletViewController?.view)!)
    }
    
    func profileviewControoler() {
        
        isChatSelect = false
        isWalletSelect = false
        isProfileSelect = true
        if isProfileSelect == true {
            chatButton.setBackgroundImage(chatImage, for: .normal)
            walletButton.setBackgroundImage(walletImage, for: .normal)
            profileButton.setBackgroundImage(profileBlueImage, for: .normal)
        }
        if (profileViewController == nil) {
            
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            //            self.corporateUserTypeDictionry?.setObject(corporateSelcted, forKey: "corporateUserType" as NSCopying)
            //            self.corporateUserTypeDictionry?.setObject(countrYSmallName, forKey: "countrySmallName" as NSCopying)
            //            vc.corporateUserDic = corporateUserTypeDictionry
            profileViewController = vc
        }
        var frame = viewControllersUIView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        viewControllersUIView.addSubview((profileViewController?.view)!)
    }
}

// MARK :- UITableView
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menuItems.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "HomeTableViewCellID") as? HomeTableViewCell
        let data = menuItems[indexPath.row]
        cell?.nameLabel?.text = data
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isSelect = true
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3{
            sideView.layer.shadowOpacity = 0
            sideView.layer.shadowRadius = 0
            hideButton.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.sideViewLeadingSpace.constant = -275
                self.view.layoutIfNeeded()
            })
        }else {
            logOutFromAWS()
        }
        isSelect = false
    }
}

// MARK :- CheckUIDevice
extension UIDevice {
    
    /*
     check this:
     https://stackoverflow.com/questions/11197509/how-to-get-device-make-and-model-on-ios/11197770#11197770
     */
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    func isPhoneX() -> Bool {
        return ((UIDevice.current.modelName == "iPhone10,3") || (UIDevice.current.modelName == "iPhone10,6"))
    }
    
}

// MARK :- GetGoogleUserData
extension HomeViewController {
    
    func getGoogleUserData() {
        
        let googleUser = GIDSignIn.sharedInstance().currentUser
        if googleUser?.profile.email != nil{
            print("Email is :-", googleUser?.profile.email as Any )
        }else{
            print("Email is nil")
        }
        if googleUser?.profile.name != nil{
            userNameLabel.text = googleUser?.profile.name
            self.fristName = (googleUser?.profile.name)!
            print("UserName is :-", googleUser?.profile.name as Any )
            
            // ProfileNamebutton
            let profileText = String(format: "%@", String((self.fristName.first)!))
            self.profileNameButton.setTitle(profileText.uppercased(), for: .normal)
        }else{
            print("UserName is nil")
        }
        if (googleUser?.profile.hasImage != nil) {
            let picURL = googleUser?.profile.imageURL(withDimension: 100)
            print("Profile pic : - ", picURL as Any)
            let data = (NSData(contentsOf: (picURL as URL?)!))
            print(data!)
        }else{
            print("UserName is nil")
        }
    }
}

// MARK :- GetFacebookUserData
extension HomeViewController {
    
    func getFacebookUserData() {
        
        let imageGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "picture.type(large)"])
        let imageConnection = FBSDKGraphRequestConnection()
        imageConnection.add(imageGraphRequest, completionHandler: { (connection, result, error) in
            guard let imageResult = result as? NSDictionary else  { return}
            if let imageURL = URL(string:(((imageResult.value(forKey: "picture") as AnyObject).value(forKey: "data") as AnyObject).value(forKey: "url") as? String)!) {
                //   self.imageURL = imageURL
                print("ImageURL Details :-", imageURL)
                let data = NSData(contentsOf: imageURL as URL)
                print(data!)
            }
        })
        imageConnection.start()
        let userGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email,first_name, middle_name, last_name, link"])
        let userConnection = FBSDKGraphRequestConnection()
        userConnection.add(userGraphRequest, completionHandler: { (connection, result, error) in
            guard let userResult = result as? NSDictionary else { return }
            if let userName = userResult.value(forKey: "name")  as? String {
                print("UserName Details :-", userName)
                self.userNameLabel.text = userName
            }
            if let email = userResult.value(forKey: "email")  as? String {
                print("Email Details :-", email)
            }
            if let id = userResult.value(forKey: "id")  as? String {
                print("Id Details :-", id)
            }
            if let first_name = userResult.value(forKey: "first_name")  as? String {
                print("first_name Details :-", first_name)
                self.fristName = first_name
            }
            if let middle_name = userResult.value(forKey: "middle_name")  as? String {
                print("middle_name Details :-", middle_name)
            }
            if let last_name = userResult.value(forKey: "last_name")  as? String {
                print("last_name Details :-", last_name)
                self.lastName = last_name
            }
            if let link = userResult.value(forKey: "link")  as? String {
                print("link Details :-", link)
            }
            // ProfileNamebutton
            let profileText = String(format: "%@%@", String((self.fristName.first)!),
                                     String((self.lastName.first)!))
            self.profileNameButton.setTitle(profileText.uppercased(), for: .normal)
        })
        userConnection.start()
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                self.title = self.user?.username
                print("self.title", self.title as Any)
                //   self.tableView.reloadData()
            })
            return nil
        }
    }    
}


//// MARK :- SignManager
//extension HomeViewController {
//
//
//    func wipeAll() {
//        if (currentSignInProvider != nil) {
//            // fix login cache
//            dropLogin(currentSignInProvider?.identityProviderName)
//        }
//        credentialsProvider?.clearKeychain()
//    }
//
//    func dropLogin(_ key: String?) {
//        var shorterList: [String : String] = [:]
//        shorterList = loginCache
//        shorterList.removeValue(forKey: key!)
//        loginCache = shorterList
//    }
//
////    func interceptApplication(_ application: UIApplication?, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any]?) -> Bool {
////        let userDefaults = UserDefaults.standard
////        userDefaults.set(false, forKey: AWSIdentityManagerUserDefaultsProvidersOk) // Assume they are not ok
////        restartAnyExistingSessions(application, didFinishLaunchingWithOptions: launchOptions)
////        return true
////    }
////    func interceptApplication(_ application: UIApplication?, open url: URL?, sourceApplication: String?, annotation: Any?) -> Bool {
////        if (currentSignInProvider != nil) {
////            return currentSignInProvider.interceptApplication(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
////        } else {
////            return true
////        }
////    }
////
//    func restartAnyExistingSessions(_ application: UIApplication?, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any]?) {
//        // Restart any sessions found.
//        for provider: Any? in activeProviders()! {
//
//            currentSignInProvider = provider as? AWSSignInProvider
//        }
//
//        if (currentSignInProvider != nil) {
//            if !(currentSignInProvider?.interceptApplication(application!, didFinishLaunchingWithOptions: launchOptions))! {
//                print("Unable to instantiate AWSSignInProvider for existing session.")
//            }
//        }
//    }
//
//    func activeProviders() -> [Any]? {
//        var signInProviderClass: AnyClass? = nil
//        var providerArray: [AnyHashable]
//        providerArray = [AWSSignInProvider?]() as! [AnyHashable]
//        let serviceInfo: AWSServiceInfo? = AWSInfo.default().defaultServiceInfo(AWSInfoIdentityManager)
//        let signInProviderKeyDictionary = serviceInfo?.infoDictionary["SignInProviderKeyDictionary"] as? [AnyHashable : Any]
//
//        if !(signInProviderKeyDictionary != nil) {
//            // no keys list - do it the old way:
//            // This maintains mobile hub compatibility
//            // Do google first, so that Facebook sessions are preferred just
//            // like before.
//            if UserDefaults.standard.object(forKey: "Google") != nil {
//                signInProviderClass = NSClassFromString("AWSGoogleSignInProvider")
//                providerArray.append(signInProviderClass?.sharedInstance())
//            }
//            if UserDefaults.standard.object(forKey: "Facebook") != nil {
//                signInProviderClass = NSClassFromString("AWSFacebookSignInProvider")
//                providerArray.append(signInProviderClass.sharedInstance())
//            }
//            if (signInProviderClass != nil) && providerArray.last == nil {
//                print("Unable to locate the SignIn Provider SDK. Signing Out any existing session...")
//                wipeAll()
//            }
//        }
//        for key: String? in signInProviderKeyDictionary {
//            if UserDefaults.standard.object(forKey: signInProviderKeyDictionary[key ?? ""] as? String ?? "") != nil {
//                if doNotInitProviders {
//                    // previous exit was not graceful
//                    print("Graceless exit - removing \(key ?? "")")
//                    UserDefaults.standard.removeObject(forKey: signInProviderKeyDictionary[key ?? ""] as? String ?? "")
//                    wipeAll() // once would be enough
//                } else {
//                    signInProviderClass = NSClassFromString(key ?? "")
//                    providerArray.append(signInProviderClass.sharedInstance()) // assemble list
//                    if signInProviderClass && providerArray.last == nil {
//                        print("Unable to locate the SignIn Provider SDK for \(key ?? ""). Signing Out any existing session...")
//                        wipeAll()
//                    }
//                }
//            }
//        }
//        return providerArray
//
//    }
//}
//

extension CALayer {
    public func configureGradientBackground(_ colors:CGColor...){
        
        let gradient = CAGradientLayer()
        
        let maxWidth = max(self.bounds.size.height,self.bounds.size.width)
        let squareFrame = CGRect(origin: self.bounds.origin, size: CGSize(width: maxWidth, height: maxWidth))
        gradient.frame = squareFrame
        
        gradient.colors = colors
        
        self.insertSublayer(gradient, at: 0)
    }
}
