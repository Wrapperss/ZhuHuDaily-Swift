//
//  ShareView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/17.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import Masonry

class ShareView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        let titleLabel = UILabel.init()
        titleLabel.text = "分享"
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.top.equalTo()(self)?.offset()(20)
            make?.centerX.equalTo()(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
