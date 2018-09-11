//
//  GradientView.swift
//  Lambo
//
//  Created by Sreekanth Gudisi on 07/09/18.
//  Copyright © 2018 simplyfi.apps. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() -> Void {
        
        let gradientLayer = layer as! CAGradientLayer
        
        let firstColor = UIColor(red: 130/255, green: 36/255, blue: 168/255, alpha: 1.0)
        let secondColor = UIColor(red: 89/255, green: 45/255, blue: 155/255, alpha: 1.0)
        
        let colours = [firstColor, secondColor]
        
        gradientLayer.colors = colours.map { $0.cgColor }
        
        gradientLayer.shadowColor = UIColor.black.cgColor
        gradientLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        gradientLayer.shadowRadius = 2.0
        gradientLayer.shadowOpacity = 0.5
        
        gradientLayer.masksToBounds = false
        
    }
    
}
