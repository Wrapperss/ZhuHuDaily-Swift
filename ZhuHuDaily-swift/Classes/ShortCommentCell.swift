//
//  ShortCommentCell.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/19.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SwiftTheme

class ShortCommentCell: UITableViewCell {

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //切成圆形
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.cornerRadius = 20
        
        self.theme_backgroundColor = ["#FEFEFE" ,"#1D1E28"]
        self.likesLabel.theme_textColor = globalTextColorPicker
        self.contentLabel.theme_textColor = globalTextColorPicker
        self.contentLabel.theme_backgroundColor = ["#FEFEFE" ,"#1D1E28"]
        self.authorlabel.theme_textColor = globalTextColorPicker
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setShorComment(_ commentModel: CommentModel) -> Void {
        self.authorlabel.text = commentModel.author
        self.avatarImageView.sd_setImage(with: URL.init(string: commentModel.avatar))
        self.contentLabel.text = commentModel.content
        self.likesLabel.text = String(commentModel.likes)
    }
    
}
