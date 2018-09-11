//
//  ChatViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 21/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit
//import AWSCognitoAuth
import AWSLex
import Messages

class ChatViewController: UIViewController, AWSLexInteractionDelegate, UITextFieldDelegate {

    
var interactionKit: AWSLexInteractionKit?
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionsTextField: UITextField!
    
    var aWSCognitoCredentialsProvider : AWSCognitoCredentialsProvider?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpTextField()
        setUpLex()
    
        aWSCognitoCredentialsProvider?.getIdentityId()
        print("aWSCognitoCredentialsProvider?.identityId :-", aWSCognitoCredentialsProvider?.identityId as Any )
    }
    
    func interactionKit(_ interactionKit: AWSLexInteractionKit, onError error: Error) {
        print("interactionKit error: \(error)")
    }
    
    func setUpLex(){
        self.interactionKit = AWSLexInteractionKit.init(forKey: "chatConfig")
        self.interactionKit?.interactionDelegate = self
    }
    
    func setUpTextField(){
        questionsTextField.delegate = self
    }
    
    func sendToLex(text : String){
        self.interactionKit?.text(inTextOut: text, sessionAttributes: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if  (questionsTextField.text?.characters.count)! > 0 {
            sendToLex(text: questionsTextField.text!)
        }
        return true
    }
    
    //handle response
    func interactionKit(_ interactionKit: AWSLexInteractionKit, switchModeInput: AWSLexSwitchModeInput, completionSource: AWSTaskCompletionSource<AWSLexSwitchModeResponse>?) {
        guard let response = switchModeInput.outputText else {
            let response = "No reply from bot"
            print("Response: \(response)")
            return
        }
        //show response on screen
        DispatchQueue.main.async{
            self.answerLabel.text = response
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
//        if let text = questionsTextField.text {
//            messages.append(MSMessage(text: text, origin: .user))
//            interactionKit.text(inTextOut: text)
//            questionsTextField.text = nil
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
}


// MARK :- Alert
extension ChatViewController {
    

}
