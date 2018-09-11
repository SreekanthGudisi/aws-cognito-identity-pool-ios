////
//// Copyright 2014-2018 Amazon.com,
//// Inc. or its affiliates. All Rights Reserved.
////
//// Licensed under the Amazon Software License (the "License").
//// You may not use this file except in compliance with the
//// License. A copy of the License is located at
////
////     http://aws.amazon.com/asl/
////
//// or in the "license" file accompanying this file. This file is
//// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//// CONDITIONS OF ANY KIND, express or implied. See the License
//// for the specific language governing permissions and
//// limitations under the License.
////
//
//import Foundation
//import AWSCognitoIdentityProvider
//
//class SignUpViewController: UIViewController {
//    
//    var pool: AWSCognitoIdentityUserPool?
//    var sentTo: String?
//    
//    @IBOutlet weak var fullname: UITextField!
//    
//    @IBOutlet weak var email: UITextField!
//    @IBOutlet weak var password: UITextField!
//    @IBOutlet weak var phone: UITextField!
//    @IBOutlet weak var copyEmail: UITextField!
//    
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.pool = AWSCognitoIdentityUserPool.init(forKey: AWSCognitoUserPoolsSignInProviderKey)
//        
//        email.addTarget(self, action: (#selector(self.textFieldDidChange(textField:))), for: UIControlEvents.editingChanged)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let signUpConfirmationViewController = segue.destination as? ConfirmSignUpViewController {
//            signUpConfirmationViewController.sentTo = self.sentTo
//            signUpConfirmationViewController.user = self.pool?.getUser(self.copyEmail.text!)
//        }
//    }
//    
//    @IBAction func signUp(_ sender: AnyObject) {
//        
//        guard let userNameValue = self.copyEmail.text, !userNameValue.isEmpty,
//            let passwordValue = self.password.text, !passwordValue.isEmpty else {
//                let alertController = UIAlertController(title: "Missing Required Fields",
//                                                        message: "Username / Password are required for registration.",
//                                                        preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                alertController.addAction(okAction)
//                
//                self.present(alertController, animated: true, completion:  nil)
//                return
//        }
//        
//        var attributes = [AWSCognitoIdentityUserAttributeType]()
//        
//        if let phoneValue = self.phone.text, !phoneValue.isEmpty {
//            let phone = AWSCognitoIdentityUserAttributeType()
//            phone?.name = "phone_number"
//            phone?.value = phoneValue
//            attributes.append(phone!)
//        }
//        
//        if let emailValue = self.email.text, !emailValue.isEmpty {
//            let email = AWSCognitoIdentityUserAttributeType()
//            email?.name = "email"
//            email?.value = emailValue
//            attributes.append(email!)
//        }
//        
//        if let fullNameValue = self.fullname.text, !fullNameValue.isEmpty {
//            let fullName = AWSCognitoIdentityUserAttributeType()
//            fullName?.name = "name"
//            fullName?.value = fullNameValue
//            attributes.append(fullName!)
//        }
//        
//        
//        
//        //sign up the user
//        self.pool?.signUp(userNameValue, password: passwordValue, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
//            guard let strongSelf = self else { return nil }
//            DispatchQueue.main.async(execute: {
//                if let error = task.error as NSError? {
//                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
//                                                            message: error.userInfo["message"] as? String,
//                                                            preferredStyle: .alert)
//                    let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
//                    alertController.addAction(retryAction)
//                    
//                    self?.present(alertController, animated: true, completion:  nil)
//                } else if let result = task.result  {
//                    // handle the case where user has to confirm his identity via email / SMS
//                    if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
//                        strongSelf.sentTo = result.codeDeliveryDetails?.destination
//                        strongSelf.performSegue(withIdentifier: "confirmSignUpSegue", sender:sender)
//                    } else {
//                        let _ = strongSelf.navigationController?.popToRootViewController(animated: true)
//                    }
//                }
//                
//            })
//            return nil
//        }
//    }
//    
//    // MARK: - UITextfieldDelegate
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
//        let emailString = email.text
//        copyEmail.text = emailString
//        fullname.resignFirstResponder()
//        email.resignFirstResponder()
//        password.resignFirstResponder()
//        phone.resignFirstResponder()
//        return true
//    }
//    
//    @objc func textFieldDidChange(textField: UITextField){
//        switch textField {
//        case email:
//            let emailString = email.text
//            copyEmail.text = emailString
//        default:
//            break
//        }
//    }
//    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool{
//        return true
//    }
//}
