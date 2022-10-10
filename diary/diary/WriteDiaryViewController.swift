//
//  WriteDiaryViewController.swift
//  diary
//
//  Created by Dongun Yun on 2022/10/09.
//

import UIKit
enum DiaryEditorMode{
    case new
    case edit(IndexPath,Diary)
}
protocol WriteDiaryViewDelegate : AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {
    private let datePicker = UIDatePicker()
    private var diaryDate : Date?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditorMode : DiaryEditorMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.confirmButton.isEnabled=false
        self.configureInputField()
        self.configureEditorMode()

        // Do any additional setup after loading the view.
    }
    private func configureEditorMode(){
        switch self.diaryEditorMode{
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
            break
        }
    }
    private func configureContentsTextView(){
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/225, alpha: 1.0)
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.5
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    private func configureDatePicker(){
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged) // for  값이 바뀔 때마다 셀렉터 함수가 실행된다. 어디서? 이 컨트롤러에서
        self.dateTextField.inputView = self.datePicker
    }
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy 년 MM 월 dd일 (EEEEE)"
        formmater.locale = Locale(identifier: "Ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged )
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func configureInputField(){
        self.contentsTextView.delegate = self
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextDidChange(_:)), for: .editingChanged)
    }
    @objc private func titleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    @objc private func dateTextDidChange(_ textField : UITextField){
        self.validateInputField()
    }
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        
        
        //notification center 사용
        switch self.diaryEditorMode{
        case .new :
            let diary = Diary(uuidString: UUID().uuidString,title: title, contents: contents, date: date, isStar: false)
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(_, diary) :
            let diary = Diary(uuidString:diary.uuidString ,title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                object: [
                    "diary" : diary,
                ],
                userInfo: nil)
            
        }
        

        self.navigationController?.popViewController(animated: true)
    }
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text?.isEmpty ?? true)
    }
    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension WriteDiaryViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
        
    }
}
