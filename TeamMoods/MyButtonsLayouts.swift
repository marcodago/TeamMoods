//
//  MyButtonsLayout.swift
//  TeamMoods
//
//  Created by Marco D'Agostino on 10/12/2019.
//  Copyright © 2019 com.ibm.cio.be.MD.TeamMoods. All rights reserved.
//

import UIKit

@IBDesignable class MyButtonsLayouts: UIButton {
    
    @IBInspectable var radius: CGFloat {
        
        get {
            return self.layer.cornerRadius
        }
        
        set (newValue) {
            self.layer.cornerRadius = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setMyButtonsLayout (value: radius)
    }
    
    func setMyButtonsLayout (value: CGFloat) {
        
        self.layer.cornerRadius = value
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.8
    }
}
