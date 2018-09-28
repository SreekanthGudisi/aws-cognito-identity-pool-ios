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

class Chat1ViewController: UIViewController, AWSLexInteractionDelegate, UITextFieldDelegate {

    
var interactionKit: AWSLexInteractionKit?
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpTextField()
        setUpLex()
    
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
        if  (questionsTextField.text?.count)! > 0 {
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

}


// MARK :- Alert
extension ChatViewController {
    

}
