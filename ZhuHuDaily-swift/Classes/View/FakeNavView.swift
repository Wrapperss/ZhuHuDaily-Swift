//
//  FakeNavView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class FakeNavView: UIView {

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
    
    init(title: String) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 64))
        self.backgroundColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 0.5)
        titleLabel.text = "知乎日报"
        titleLabel.textColor = UIColor.white
        titleLabel.shadowColor = UIColor.lightGray
        titleLabel.shadowOffset = CGSize.init(width: 1, height: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.centerY.equalTo()(self.mas_centerY)?.offset()(8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(title: String) -> Void {
        self.title = title
    }

}
