//
//  TitleView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/14.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class TitleView: UIView {

    var titleLabel = UILabel()
    
    func setMessage(title: String) -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 44)
        self.backgroundColor = ZHI_HU_COLOR
        self.addTitleLabel(title)
    }
    
    private func addTitleLabel(_ title: String) -> Void {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            //make?.centerY.equalTo()(self.mas_centerY)?.insets()(UIEdgeInsets.init(top: -20, left: 0, bottom: 0, right: 0))
            make?.bottom.equalTo()(self)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 11, right: 0))
        }
    }
}
