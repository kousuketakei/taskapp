//
//  inputViewController.swift
//  taskapp
//
//  Created by 武井康祐 on 2019/10/19.
//  Copyright © 2019 KousukeTakei. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class inputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task!
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景をタップしたらdismissKeyboardを呼ぶように設定する
        let tapGesture = UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = termios.title
        contentsTextView.text = task.contens
        datePicker.date = task.date
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            self.realm.add(self.task, update: true)
            
        }
        setNotification(task: task)
        
        super.viewWillDisappear(animated)
    }
    //タスクのローカル通知を登録する
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        //タイトルと内容を設定（中身がない場合メッセージ無しで音だけの通知になるので「（××なし）を表示する）
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents = "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default()
    }
    
    //ローカル通知が発動するtrigger(日付マッチ)を作成
    let calendar = Calendar.current
    let dateComponents = Calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
    let trigger = UNCalendarNotificationTrigger.init(dateMatching:
        DateComponents, repeats: false)
    
    //identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存)
    let request = UNNotificationRequest.init(identifier: String(task.id), content: content, trigger: trigger)
    
    //ローカル通知を登録
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error)  in
    print(error ?? "ローカル通知登録 OK") //errorがnilならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
    
    }
    
    //ローカル通知を登録
    center.getPendingNotificationRequests{ (UNUserNotificationRequests { (requests: [UNNotificationRequest]) in
        for request in requests {
            print("/---------")
            print(request)
            print("/---------")
        }
        
    }
    
    
    
    
    @objc func dismissKeyboard() {
        //キーボードを閉じる
        view.endEditing(true)
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