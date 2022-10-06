//
//  MainViewController.swift
//  neonsign
//
//  Created by Dongun Yun on 2022/10/03.
//

import UIKit

class MainViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard  let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") else {return}
        self.navigationController?.pushViewController(MainViewController, animated: true)
    }
}
