//
//  SettingViewController.swift
//  neonsign_Storyboard
//
//  Created by Dongun Yun on 2022/10/06.
//

import UIKit

protocol LEDBoardSettingDelegate : AnyObject{
    func changedSetting(text : String? , textColor : UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var orangeButton: UIButton!
    
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var blackButton: UIButton!
    
    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var purpleButton: UIButton!
    
    @IBOutlet weak var greenButton: UIButton!
    
    var ledText: String?
    weak var delegate: LEDBoardSettingDelegate?
    var textColor: UIColor = .yellow
    var bgColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
    }
    
    private func configureView(){
        if  let ledText = self.ledText {
            self.textField.text = ledText
        }
    }
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender==self.yellowButton {
            self.changeTextColor(color: .yellow)
            self.textColor = .yellow
        }
        if sender==self.purpleButton {
            self.changeTextColor(color: .purple)
            self.textColor = .purple
            
        }
        if sender==self.greenButton {
            self.changeTextColor(color: .green)
            self.textColor = .green
            
        }
    }
    
    @IBAction func tapBGColorButton(_ sender: UIButton) {
        if sender==self.blackButton {
            self.changeBGColor(color: .black)
            self.bgColor = .black
        }
        if sender==self.blueButton {
            self.changeBGColor(color: .blue)
            self.bgColor = .blue
            
        }
        if sender==self.orangeButton {
            self.changeBGColor(color: .orange)
            self.bgColor = .orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        self.delegate?.changedSetting(
            text: self.textField.text ,
            textColor: self.textColor,
            backgroundColor: self.bgColor)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor){
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.2

    }
    private func changeBGColor(color: UIColor){
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
}
