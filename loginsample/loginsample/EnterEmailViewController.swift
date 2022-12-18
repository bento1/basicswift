//
//  EnterEmailViewController.swift
//  loginsample
//
//  Created by Dongun Yun on 2022/10/16.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.layer.cornerRadius = 25
        self.nextButton.isHidden = true
        self.errorMessageLabel.isHidden = true
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        self.emailTextField.becomeFirstResponder() //처음에 커서 올락감
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.view.backgroundColor? = .clear
    }

    @IBAction func tapNextButton(_ sender: UIButton) {
        //firebase
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규사용자 생성
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            [weak self] authResult, error in
            guard let self = self else {return}
            self.showMainViewController()
        })
        
    }
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let LoginCompleteViewController = storyboard.instantiateViewController(withIdentifier: "LoginCompleteViewController")
        LoginCompleteViewController.modalPresentationStyle  = .fullScreen
        self.navigationController?.show(LoginCompleteViewController,sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapBack(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension EnterEmailViewController: UITextFieldDelegate{
    //이메일 입력이 끝나고 나서 키보드를 내리게 할 것
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        
        let isPWEmpty = passwordTextField.text == ""
        
        nextButton.isHidden = !isPWEmpty && !isEmailEmpty
        
    }
}
