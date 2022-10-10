//
//  StarViewController.swift
//  diary
//
//  Created by Dongun Yun on 2022/10/09.
//

import UIKit

class StarViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    private var diaryList = [Diary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: Notification.Name("editDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(starNotification(_:)), name: Notification.Name("starDiary"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteDiaryNotification(_:)), name: Notification.Name("deleteDiary"), object: nil)
        self.loadStarDiaryList()
        // Do any additional setup after loading the view.
    }
    @objc private func deleteDiaryNotification(_ notification: Notification){
        guard let delDiary = notification.object as? [String: Any] else {return}
        
        guard let diary = delDiary["diary"] as? Diary else {return}
    
        guard let index = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
        self.diaryList.remove(at: index)
        self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    @objc private func starNotification(_ notification: Notification){
        guard let starDiary = notification.object as? [String: Any] else {return}
        guard let diary = starDiary["diary"] as? Diary else {return}
        let isStar = diary.isStar
        
        if !isStar{
            guard let index = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
            self.diaryList.remove(at: index)
            self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
        }else{
            self.diaryList.append(diary)
            self.diaryList = self.diaryList.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
            self.collectionView.reloadData()
        }
    }
    @objc private func editDiaryNotification(_ notification: Notification){
        guard let editDiary = notification.object as? [String: Any] else {return}
        guard let diary = editDiary["diary"] as? Diary else {return}
        guard let index = self.diaryList.firstIndex(where: {$0.uuidString == diary.uuidString}) else {return}
        self.diaryList[index] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
        
    }
    private func loadStarDiaryList(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String:Any]] else {return}
        self.diaryList = data.compactMap{
            guard let uuidString = $0["uuidString"] as? String else {return nil}
            guard let title = $0["title"] as? String else {return nil}
            guard let contents = $0["contents"] as? String else {return nil}
            guard let date = $0["date"] as? Date else {return nil}
            guard let isStar = $0["isStar"] as? Bool else {return nil}
            return Diary(uuidString: uuidString ,title: title, contents: contents, date: date, isStar: isStar)
                    
        }.filter({
            $0.isStar == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
//        self.collectionView.reloadData()
    }
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    private func dateToString(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
extension StarViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else {return UICollectionViewCell()}
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
}
extension StarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) - 20, height: 80)
    }}

extension StarViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else {return}
        let diary = self.diaryList[indexPath.row]
        viewController.diary=diary
        viewController.indexPath=indexPath
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
