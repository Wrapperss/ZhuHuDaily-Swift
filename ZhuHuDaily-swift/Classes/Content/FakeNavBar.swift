//
//  FakeNavBar.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SVProgressHUD

class FakeNavBar: UIView {

    
    typealias BackButtonBlock = () -> Void
    
    var backBlock: BackButtonBlock?
    
    var currentContent: StoryDetailModel?
    
    //默认是没有收藏的
    var isFavorite: Bool = false {
        didSet {
            if isFavorite == false {
                favoriteButton.setImage(UIImage.init(named: "favorite"), for: .normal)
            }
            else {
                favoriteButton.setImage(UIImage.init(named: "favoirte-filling"), for: .normal)
            }
        }
    }
    
    var favoriteButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        //返回按钮
        let backButton = UIButton.init(frame: CGRect.init(x: 10, y: 5, width: 30, height: 30))
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        backButton.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 15
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        self.addSubview(backButton)
        
        //收藏按钮
        favoriteButton.frame = CGRect.init(x: APP_WIDTH - 50, y: 5, width: 30, height: 30)
        favoriteButton.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        favoriteButton.setImage(UIImage.init(named: "favorite"), for: .normal)
        favoriteButton.layer.masksToBounds = true
        favoriteButton.layer.cornerRadius = 15
        favoriteButton.addTarget(self, action: #selector(favorote), for: .touchUpInside)
        self.addSubview(favoriteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //返回功能
    func backButtonClick() -> Void {
        if backBlock != nil {
            backBlock!()
        }
    }
    
    //收藏功能
    func favorote() -> Void {
        if isFavorite == false {
            CacheTool.shared.addFavoriteStory(currentContent!)
            SVProgressHUD.showSuccess(withStatus: "收藏成功")
            
            isFavorite = true
        }
        else {
            CacheTool.shared.deleteFavorite(currentContent!.id)
            SVProgressHUD.showSuccess(withStatus: "取消收藏")
            isFavorite = false
        }
    }
}
