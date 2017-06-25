//
//  LongCommentCell.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/18.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftTheme

class LongCommentCell: UITableViewCell {
    
    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    // container view 高度的优先级约束
    @IBOutlet weak var containerViewHeightLayoutConstrain: NSLayoutConstraint!
    
    // container view相对于superview的bottom约束
    @IBOutlet weak var containerViewBottomLayoutConstrain: NSLayoutConstraint!
    
    
    typealias ExpandClosure = () -> Void
    
    
    var expandClosure:ExpandClosure?
    
    // 是否显示"收起"按钮
    let isShowCollapse:Bool = true

    // 收起或展开操作
    var expanded:Bool? {
        didSet{
            // 收起操作
            if !expanded! {
                containerViewHeightLayoutConstrain.priority = 800
                showAllButton.isHidden = false
                showAllButton.setTitle("显示全部", for: UIControlState())
                showAllButton.setImage(UIImage(named: "down"), for: UIControlState())
                
            }else{
                // 展开操作
                containerViewHeightLayoutConstrain.priority = 750 // < 降低container view的高度约束优先级，使其小于UILabel的Vertical Constrain（800）
                
                showAllButton.setTitle("收起", for: UIControlState())
                showAllButton.setImage(UIImage(named: "up"), for: UIControlState())
                if !isShowCollapse {
                    containerViewBottomLayoutConstrain.priority = 1000
                    showAllButton.isHidden = true
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //切成圆形
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.cornerRadius = 20
        
        //修改sentient的字间距
        let dictionary = [NSKernAttributeName : 5]
        contentLabel.attributedText = NSAttributedString.init(string: contentLabel.text!, attributes: dictionary)
        
        self.theme_backgroundColor = globalBackgroundColorPicker
        self.authorLabel.theme_textColor = globalTextColorPicker
        self.contentLabel.theme_textColor = globalTextColorPicker
        self.contentLabel.theme_backgroundColor = globalBackgroundColorPicker
        self.likesLabel.theme_textColor = globalTextColorPicker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            super.setSelected(false, animated: true)
            if expandClosure != nil {
                expandClosure!()
            }
        }
    }

    func setLongComment(_ commentModel: CommentModel) -> Void {
        self.authorLabel.text = commentModel.author
        self.avatarImageView.sd_setImage(with: URL.init(string: commentModel.avatar))
        self.contentLabel.text = commentModel.content
        self.likesLabel.text = String(commentModel.likes)
        
    }
    @IBAction func showAllButtonClick(_ sender: Any) {
        if expandClosure != nil {
            expandClosure!()
        }
    }
}
