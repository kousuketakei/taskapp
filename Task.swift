//
//  Task.swift
//  
//
//  Created by 武井康祐 on 2019/10/18.
//

import RealmSwift

class Task: Object {
    //管理用 ID。プライマリーキー
    @Object dynamic var id = 0
    
    //タイトル
    @Object dynamic var title = ""
    
    //内容
    @Object dynamic var contents = ""
    
    //日時
    @Object dynamic var date = Date()
    
    /**
    　idをプライマリーキーとして設定
     */
    override static func primaryKey() ->String? {
        return "id"
    }
}
