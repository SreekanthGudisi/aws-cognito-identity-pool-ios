//
//  Branding.swift
//  LoyaltyApp
//
//  Created by Sreekanth Gudisi on 06/08/18.
//  Copyright © 2018 SimplyFI. All rights reserved.
//

import Foundation
import UIKit

class Branding {

    static let darkColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.05, alpha: 1.0)
    static let lightBlueColor = UIColor(red: 30.0/255.0, green: 135.0/255.0, blue: 240.0/255.05, alpha: 1.0)
    static let whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.05, alpha: 1.0)
    static let orangeColor = UIColor(red: 247.0/255.0, green: 191.0/255.0, blue: 88.0/255.0, alpha: 1.0)
    static let yellowColor = UIColor(red: 242.0/255.0, green: 237.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    static let activityIndicatorBackGroundColor = UIColor(red: 107.0/255.0, green: 188.0/255.0, blue: 184.0/255.0, alpha: 1.0)
    
    static func dinRegularFont() -> UIFont {
        return UIFont(name: "DIN-Regular", size: 15)!
    }
    
    static func dinRegularSmallFont() -> UIFont {
        return UIFont(name: "DIN-Regular", size: 12)!
    }
    
    static func gilroyBoldFont() -> UIFont {
        return UIFont(name: "Gilroy-Bold", size: 16)!
    }
    
    static func fontForPickerView() -> UIFont {
        return UIFont(name: "DIN-Medium", size: 20)!
    }
}

extension UISegmentedControl{
    func applyBranding() {
        let attributedSegmentFont = [NSAttributedStringKey.font: Branding.gilroyBoldFont(),
                                     NSAttributedStringKey.foregroundColor : Branding.lightBlueColor]
        setTitleTextAttributes(attributedSegmentFont, for: .normal)
        
        let selectTitleTextAttributes = [NSAttributedStringKey.foregroundColor: Branding.whiteColor]
        setTitleTextAttributes(selectTitleTextAttributes, for: .selected)
    }
}

