//
//  SuguePresentationViewController.swift
//  neonsign
//
//  Created by Dongun Yun on 2022/10/03.
//

import UIKit

class SuguePresentationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tabBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
