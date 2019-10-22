//
//  Task.swift
//
//
//  Created by 武井康祐 on 2019/10/18.
//
import RealmSwift

@objcMembers class Task: Object {
    //管理用 ID。プライマリーキー
    dynamic var id = 0
    
    
    dynamic var title = ""
    
    
    dynamic var contents = ""
    
    
    dynamic var date = Date()
    
    /**
    　idをプライマリーキーとして設定
     */
    override static func primaryKey() ->String? {
        return "id"
    }
}
