//
//  FakeNavView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SwiftTheme

class FakeNavView: UIView {

    typealias SlideBlock = () -> Void
    var slideAction: SlideBlock?
    
    var titleLabel = UILabel()
    var title = "" {
        didSet {
            if title == "" {
                self.titleLabel.text = "今日新闻"
            }
            else {
                self.titleLabel.text = title
            }
        }
    }
    
    init(title: String, isShowSlidButton: Bool) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 64))
        //self.backgroundColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
        self.theme_backgroundColor = globalBackgroundColorPicker
        titleLabel.text = title
        titleLabel.textColor = UIColor.white
        titleLabel.shadowColor = UIColor.lightGray
        titleLabel.shadowOffset = CGSize.init(width: 1, height: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.centerY.equalTo()(self.mas_centerY)?.offset()(8)
        }
        
        if isShowSlidButton {
            let slideButton = UIButton.init()
            //slideButton.frame = CGRect.init(x: 10, y: 10, width: 30, height: 30)
            slideButton.setImage(UIImage.init(named: "slideButton"), for: .normal)
            slideButton.addTarget(self, action: #selector(slideMenu), for: .touchUpInside)
            self.addSubview(slideButton)
            slideButton.mas_makeConstraints { (make) in
                make?.centerY.equalTo()(self.mas_centerY)?.offset()(8)
                make?.left.equalTo()(self)?.offset()(20)
                make?.size.equalTo()(CGSize.init(width: 25, height: 25))
            }
        }
    }
    
    func slideMenu() -> Void {
        if self.slideAction != nil {
            slideAction!()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(title: String) -> Void {
        self.title = title
    }

}
