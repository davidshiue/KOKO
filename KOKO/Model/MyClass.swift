//
//  MyClass.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import Foundation

class Man{
    var name: String
    var id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}

class Friend{
    var name: String
    var status: Int
    var isTop: String
    var fid: String
    var updateDate: String

    init(name: String, status: Int, isTop: String, fid: String, updateDate: String) {
        self.name = name
        self.status = status
        self.isTop = isTop
        self.fid = fid
        self.updateDate = updateDate
    }
}
