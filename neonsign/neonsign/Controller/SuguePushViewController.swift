//
//  SuguePushViewController.swift
//  neonsign
//
//  Created by Dongun Yun on 2022/10/03.
//

import UIKit

class SuguePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
