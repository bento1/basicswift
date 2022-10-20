//
//  LoginViewController.swift
//  loginsample
//
//  Created by Dongun Yun on 2022/10/15.
//

import UIKit

class LoginViewController : UIViewController{
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.configureButton()
    }
    func configureButton(){
        [self.emailLoginButton,
        self.googleLoginButton,
         self.appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func tapAppleLogin(_ sender: UIButton) {
    }
    @IBAction func tapemailLogin(_ sender: UIButton) {
    }
    @IBAction func tapGoogleLogin(_ sender: UIButton) {
    }
}
