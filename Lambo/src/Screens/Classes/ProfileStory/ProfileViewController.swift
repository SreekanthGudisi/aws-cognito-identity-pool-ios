//
//  ProfileViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 21/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class ProfileViewController: UIViewController {

    var arrImageName: [String] = ["edit", "edit"]
    private let myArray1: NSArray = ["Binance","Bitfinex"]
    private let myArray2: NSArray = ["API Key : 12788 8998 99 ","API Key : 12788 8998 99 "]
    private let myArray3: NSArray = ["API Secret : jsisjd!hjsiis","API Secret : jsisjd!hjsiis"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        personImage.layer.cornerRadius = personImage.frame.height/2
        personImage.clipsToBounds = true
        
        getGoogleUserData()
        getFacebookUserData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.numberOfLines = 2
//        label.textColor = UIColor.black
//        label.text = String(format: "  Total Organizations (5)")
//        label.backgroundColor = UIColor.groupTableViewBackground
//        return label
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (myArray1.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCellID") as? ProfileTableViewCell
        cell?.array1Label.text = (myArray1[indexPath.row] as! String)
        cell?.array2Label.text = (myArray2[indexPath.row] as! String)
        cell?.myImage.image = UIImage(named:self.arrImageName[indexPath.row])
        return cell!
    }
}

// MARK :- GetGoogleUserData
extension ProfileViewController {
    
    func getGoogleUserData() {
        
        let googleUser = GIDSignIn.sharedInstance().currentUser
        if googleUser?.profile.email != nil{
            emailLabel.text = googleUser?.profile.email
        }else{
            print("Google Email is nil")
        }
        if googleUser?.profile.name != nil{
            nameLabel.text = googleUser?.profile.name
        }else{
            print("Google UserName is nil")
        }
        if (googleUser?.profile.hasImage != nil) {
            let picURL = googleUser?.profile.imageURL(withDimension: 100)
            print("Profile pic : - ", picURL as Any)
            let data = (NSData(contentsOf: (picURL as URL?)!))
            print(data!)
            self.personImage.image = UIImage(data: data! as Data)
        }else{
            print("Google PersonImage is nil")
        }
//        let data = NSData(contentsOf: imageURL as URL)
//        print(data!)
//        self.personImage.image = UIImage(data: data! as Data)
//        self.imageURL = googleUser?.profile.imageURL(withDimension: GoogleSignInProviderProfileImageDimension)
        // Set any additional proflie attributes here. This method is called after a user signs in with a provider.
    }
}
// MARK :- GetFacebookUserData
extension ProfileViewController {
    
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
                self.personImage.image = UIImage(data: data! as Data)
            }
        })
        imageConnection.start()
        let userGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email,first_name, middle_name, last_name, link"])
        let userConnection = FBSDKGraphRequestConnection()
        userConnection.add(userGraphRequest, completionHandler: { (connection, result, error) in
            guard let userResult = result as? NSDictionary else { return }
            if let userName = userResult.value(forKey: "name")  as? String {
                print("UserName Details :-", userName)
                self.nameLabel.text = userName
            }
            if let email = userResult.value(forKey: "email")  as? String {
                print("Email Details :-", email)
                self.emailLabel.text = email
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
    
}
