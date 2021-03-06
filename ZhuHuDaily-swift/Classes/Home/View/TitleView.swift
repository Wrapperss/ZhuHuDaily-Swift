//
//  TitleView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/14.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SwiftTheme

class TitleView: UIView {

    var titleLabel = UILabel()
    
    func setMessage(title: String) -> Void {
        self.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 44)
        self.theme_backgroundColor = ["#149EEC", "#1D1E28"]
        self.titleLabel.theme_textColor = ["#FFFFFF" ,"#ECF0F1"]
        self.addTitleLabel(title)
    }
    
    private func addTitleLabel(_ title: String) -> Void {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(self.mas_centerX)
            make?.bottom.equalTo()(self)?.insets()(UIEdgeInsets.init(top: 0, left: 0, bottom: 11, right: 0))
        }
    }
}
