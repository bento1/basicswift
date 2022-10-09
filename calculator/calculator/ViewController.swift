//
//  ViewController.swift
//  calculator
//
//  Created by Dongun Yun on 2022/10/08.
//

import UIKit
enum Operation{
    case Add
    case Subtract
    case Divide
    case Multiply
    case Plus
    case unknown
}
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//    operator button
    @IBAction func tapEqulButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
        self.numberOutputLabel.text = self.result
    }

    @IBAction func tapPlusButton(_ sender: UIButton) {
        self.operation(.Plus)
    }
    @IBAction func tapMinusButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    @IBAction func tapMultipleButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }

    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }

    
    //display
    var displayNumber = "" // 누를때마다 라벨에 표시
    var firstOperand = "" // 이전 계산 값을 저장
    var secondOperand = "" // 새롭게 입력될 값 저장 두번째 피연산자
    var result = "" // 계산의 결과
    var currentOperation : Operation = .unknown // 연산자
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    //input button
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for : .normal) else {return}
        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8 , !self.displayNumber.contains("."){
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }
    @IBAction func tapClearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.secondOperand = ""
        self.firstOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }
    func operation ( _ operation:Operation){
        if self.currentOperation != .unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                self.displayNumber = ""
                
                guard let firstOperand = Double(self.firstOperand) else {return}
                guard let secondOperand = Double(self.secondOperand) else {return}
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand)"
                    
                default:
                    break
                }
                if let result = Double(self.result) , result.truncatingRemainder(dividingBy: 1) == 0{
                    self.result = "\(Int(result))"
                }
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            self.currentOperation = operation
        }else{
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
    }

}

