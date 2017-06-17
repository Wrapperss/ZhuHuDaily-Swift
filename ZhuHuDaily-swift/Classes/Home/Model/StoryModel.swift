//
//  StoryModel.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/10.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class StoryModel: NSObject, NSCoding {
    var title = ""
    var images: [String] = []
    var id = ""
    var multipic = false
    
    override init() {}
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.images, forKey: "images")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.multipic, forKey: "multipic")
    }
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.images = aDecoder.decodeObject(forKey: "images") as! [String]
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.multipic = aDecoder.decodeBool(forKey: "multipic")
    }
}
