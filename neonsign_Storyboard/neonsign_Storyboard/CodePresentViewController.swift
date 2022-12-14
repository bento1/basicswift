//
//  CodePresentViewController.swift
//  neonsign_Storyboard
//
//  Created by Dongun Yun on 2022/10/06.
//

import UIKit

protocol SendDataDelegate : AnyObject{
    func sendData(name: String)

}

class CodePresentViewController: UIViewController {
    
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "Dongun From Prev Page")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    var name : String?
    /*
     @IBOutlet weak var nameLabel: UILabel!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
