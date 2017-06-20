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
        
        let sinaButton = UIButton()
        let weiChatButton = UIButton()
        let QQZoneButton = UIButton()
        
        //新浪微博的分享按钮
        sinaButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        sinaButton.setTitle("新浪", for: .normal)
        sinaButton.setTitleColor(UIColor.black, for: .normal)
        sinaButton.setTitleColor(UIColor.gray, for: .highlighted)
        self.addSubview(sinaButton)
        sinaButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.left.equalTo()(self.mas_left)?.offset()(35)
        }
        
        //朋友圈的分享按钮
        weiChatButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        weiChatButton.setTitle("朋友圈", for: .normal)
        weiChatButton.setTitleColor(UIColor.black, for: .normal)
        weiChatButton.setTitleColor(UIColor.gray, for: .highlighted)
        self.addSubview(weiChatButton)
        weiChatButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.centerX.equalTo()(self)?.offset()(-20)
        }
        
        //QQ空间的分享按钮
        QQZoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        QQZoneButton.setTitle("QQ空间", for: .normal)
        QQZoneButton.setTitleColor(UIColor.black, for: .normal)
        QQZoneButton.setTitleColor(UIColor.gray, for: .highlighted)
        self.addSubview(QQZoneButton)
        QQZoneButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.right.equalTo()(self)?.offset()(-35)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
