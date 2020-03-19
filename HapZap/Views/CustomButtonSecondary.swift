//
//  CustomButtonSecondary.swift
//  HapZap
//
//  Created by Christian Jäderberg on 2020-03-19.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class CustomButtonSecondary: UIButton {
    
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
        setTitleColor(self.hapZapColor.dark, for: .normal)
    }
    
}

