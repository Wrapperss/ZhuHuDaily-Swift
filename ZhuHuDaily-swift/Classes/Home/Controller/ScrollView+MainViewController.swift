//
//  ScrollView+MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit


extension MainViewController {
    
    // scrollView 已经滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = tableView.contentOffset.y / HEAD_VIEW_HEIGHT
        
        self.fakeNav.backgroundColor = UIColor.colorWithZhuHu(alpha: alpha)
        if alpha > 1 {
            self.fakeNav.titleLabel.shadowColor = UIColor.clear
        }
        else {
            self.fakeNav.titleLabel.shadowColor = UIColor.lightGray
        }
    }
}

extension UIColor {
    class func colorWithZhuHu(alpha: CGFloat) -> UIColor {
        return UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: alpha)
    }
}
