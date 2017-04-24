//
//  StoryDetailModel.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/15.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class StoryDetailModel: NSObject, NSCoding {
    var id = ""
    var title = ""
    var body = ""
    var css = [String]()
    var imageSource = ""
    var image = ""
    var shareUrl = ""
    var images = [String]()
    
    override init() {}
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return [
            "imageSource" : "image_source",
            "shareUrl" : "share_url"
            ]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(body, forKey: "body")
        aCoder.encode(css, forKey: "css")
        aCoder.encode(imageSource, forKey: "imageSource")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(shareUrl, forKey: "shareUrl")
        aCoder.encode(images, forKey: "images")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.body = aDecoder.decodeObject(forKey: "body") as! String
        self.css = aDecoder.decodeObject(forKey: "css") as! Array
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.imageSource = aDecoder.decodeObject(forKey: "imageSource") as! String
        self.images = aDecoder.decodeObject(forKey: "images") as! Array
        self.shareUrl = aDecoder.decodeObject(forKey: "shareUrl") as! String
    }
    
}
