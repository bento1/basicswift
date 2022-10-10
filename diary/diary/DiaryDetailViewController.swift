//
//  DiaryDetailViewController.swift
//  diary
//
//  Created by Dongun Yun on 2022/10/09.
//

import UIKit

//protocol DiaryDetailDelegate : AnyObject {
//    func didSelectDelete(indexPath : IndexPath)
//    func didSelectStar(indexPath:IndexPath, isStar:Bool)
//}

class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    weak var delegate: DiaryDetailDelegate?
    
    var diary: Diary?
    var indexPath: IndexPath?
    var startButton : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)),name: Notification.Name("starDiary"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func starDiaryNotification (_ notification: Notification){
        guard let starDiaryDic = notification.object as? [String : Any] else {return}
        guard let starDiary = starDiaryDic["diary"] as? Diary else {return}
        if starDiary.uuidString == self.diary?.uuidString {
            self.diary?.isStar = starDiary.isStar
            self.configureView()
        }
        
    }
    private func configureView(){
        guard let diary = self.diary else {return}
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
        self.startButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStartButton))
        self.startButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.startButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.startButton
    }
    @objc private func tapStartButton(){

        guard let isStar = self.diary?.isStar else {return}
//        guard let indexPath = self.indexPath else {return}

        
        if isStar {
            self.startButton?.image = UIImage(systemName: "star")
        }else{
            self.startButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        
        //아래 함수는 viewController와 DetailViewController와 만 데이터가 주고 받아짐.
        //notificationcenter를 통해 star에서 불러진 DetailView에서 올려진 알람을 구독하게 한다.
        //self.delegate?.didSelectStar(indexPath: indexPath, isStar: self.diary?.isStar ?? false)
        NotificationCenter.default.post(
            name: Notification.Name("starDiary"),
            object: [
                "diary" : self.diary ,
            ],
            userInfo: nil)
    }
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else {return}
        guard let diary = self.diary else {return}
        viewController.diaryEditorMode = .edit(indexPath, diary)
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("editDiary"), object: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc private func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else {return}
//        guard let row = notification.userInfo?["indexPath.row"] as? Int else {return}
        self.diary = diary
        self.configureView()
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
//        guard let uuidString = self.diary?.uuidString else {return}
//        self.delegate?.didSelectDelete(indexPath: indexPath)
        NotificationCenter.default.post(
            name: Notification.Name("deleteDiary"),
            object: [
                "diary": self.diary
            ],
            userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }

    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
