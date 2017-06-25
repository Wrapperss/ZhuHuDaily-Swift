//
//  ThemModel.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/22.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class ThemModel: NSObject, NSCoding {

    var id = ""
    var name = ""
    var descriptionText = ""
    var thumbnail = ""
    
    override init() {}
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return  [
            "descriptionText" : "description"
        ]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(descriptionText, forKey: "descriptionText")
        aCoder.encode(thumbnail, forKey: "thumbnail")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.descriptionText = aDecoder.decodeObject(forKey: "descriptionText") as! String
        self.thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as! String
    }
}
