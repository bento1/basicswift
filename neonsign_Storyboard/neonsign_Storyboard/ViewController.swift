//
//  ViewController.swift
//  neonsign_Storyboard
//
//  Created by Dongun Yun on 2022/10/06.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate, LEDBoardSettingDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentLabel.textColor = .yellow
        // Do any additional setup after loading the view.
    }

    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePush") as? CodePushViewController else {return}
        viewController.name = "Dongun"
        viewController.delegate =  self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController =
                self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
        viewController.name = "Donguns"
        viewController.delegate =  self
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController,animated: true,completion: nil)
    }
    
    func sendData(name:  String){
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
    override func prepare(for segue:UIStoryboardSegue,sender: Any?){
        if let settingViewController = segue.destination as? SettingViewController{
            settingViewController.delegate = self
            settingViewController.ledText=self.contentLabel.text
            settingViewController.textColor = self.contentLabel.textColor
            settingViewController.bgColor = self.view.backgroundColor ?? .black
        }
    }
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text=text {
            self.contentLabel.text = text
        }
        self.contentLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}

