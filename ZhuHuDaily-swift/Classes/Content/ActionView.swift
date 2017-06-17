//
//  ActionView.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/17.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import Masonry

protocol ActionViewDelegate {
    func commentButtonClick() -> Void
    func shareButtonClick() -> Void
}

class ActionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: ActionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white

        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        let topLayer = CALayer()
        topLayer.backgroundColor = UIColor.gray.cgColor
        topLayer.frame = CGRect.init(x: self.bounds.origin.x + 1, y: 0, width: APP_WIDTH, height: 1)
        self.layer.addSublayer(topLayer)
        
        let midLayer = CALayer()
        midLayer.backgroundColor = UIColor.gray.cgColor
        midLayer.frame = CGRect.init(x: 0.5 * width - 1, y: 0.2 * height, width: 1, height: 0.6 * height)
        self.layer.addSublayer(midLayer)
        
        let commentButton = UIButton.init()
        commentButton.setTitle("查看评论", for: .normal)
        commentButton.setTitleColor(UIColor.black, for: .normal)
        commentButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        commentButton.addTarget(self, action: #selector(comment), for: .touchUpInside)
        self.addSubview(commentButton)
        commentButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.left.equalTo()(self)?.offset()(0.15 * width)
        }
        
        
        let shareButton = UIButton.init()
        shareButton.setTitle("分享", for: .normal)
        shareButton.setTitleColor(UIColor.black, for: .normal)
        shareButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
        self.addSubview(shareButton)
        shareButton.mas_makeConstraints { (make) in
            make?.centerY.equalTo()(self)
            make?.right.equalTo()(self)?.offset()(-0.2 * width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func comment() -> Void {
        delegate?.commentButtonClick()
    }
    func share() -> Void {
        delegate?.shareButtonClick()
    }
}
