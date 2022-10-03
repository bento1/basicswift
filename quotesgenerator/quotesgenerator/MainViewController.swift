//
//  MainViewController.swift
//  quotesgenerator
//
//  Created by Dongun Yun on 2022/10/02.
//

import UIKit

class MainViewController : UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    let quotes = [
    Quote(contentes: "죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다.", name: "벤다이크"),
    Quote(contentes: "나는 나 자신을 뺴 놓고는 모두 안다", name: "비용"),
    Quote(contentes: "편견이란 실효성이 없는 의견이다.", name: "암브로스 빌"),
    Quote(contentes: "난 잘생겼다.", name: "윤동운"),
    ]
    @IBAction func tapQuoteGeneratorButton(_ sender: UIButton) {
        let random = Int(arc4random_uniform(3)) // 0~2 난수 발생
        let quote:Quote = quotes[random]
        self.quoteLabel.text=quote.contentes
        self.nameLabel.text=quote.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
