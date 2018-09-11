//
//  WalletViewController.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 21/08/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {

    @IBOutlet weak var shadowUIView: UIView!
    @IBOutlet weak var bitCoinUIVIew: UIView!
    @IBOutlet weak var bitCoinUIVIew1: UIView!
    @IBOutlet weak var bitCoinUIVIew2: UIView!
    
    
    @IBOutlet weak var autoInvestUIVIew: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    var isSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        isSelect = true
        view.alpha = 1;

        bitCoinUIVIew.layer.cornerRadius = 30
        bitCoinUIVIew.layer.shadowColor = UIColor.black.cgColor
        bitCoinUIVIew.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        bitCoinUIVIew.layer.shadowRadius = 1.7
        bitCoinUIVIew.layer.shadowOpacity = 0.45
        
        autoInvestUIVIew.isHidden = true
    }

    // IBActions
    @IBAction func switchButtonTapped(_ sender: Any) {
        
        isSelect = true
        if switchButton.isOn {
            view.alpha = 1;
            autoInvestUIVIew.isHidden = false
        }
    }

    
    @IBAction func tapGestureButtonTappped(_ sender: Any) {
        
        isSelect = true
        autoInvestUIVIew.isHidden = true
        view.alpha = 1;
        switchButton.isOn = false
    }
    
    @IBAction func allocatedButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func riskButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        isSelect = true
        autoInvestUIVIew.isHidden = true
        view.alpha = 1;
        switchButton.isOn = false
    }
}
