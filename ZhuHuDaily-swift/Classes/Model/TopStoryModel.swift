//
//  TopStoryModel.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/11.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class TopStoryModel: NSObject, NSCoding {
    var title = ""
    var image = ""
    var id = ""
    
    override init() {
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.id, forKey: "id")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.id = aDecoder.decodeObject(forKey: "id") as! String
    }
}
