//
//  CustomButton.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-19.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class CustomButtonPrimary: UIButton {
    
    let hapZapColor = HapZapColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        setTitleColor(self.hapZapColor.accentLight, for: .normal)
        
        self.backgroundColor = self.hapZapColor.dark
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    private func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
}
