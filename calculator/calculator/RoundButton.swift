//
//  RoundButton.swift
//  calculator
//
//  Created by Dongun Yun on 2022/10/08.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var isRound: Bool = false {
        didSet{
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
