//
//  StoryViewCell.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/7.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftTheme

class StoryViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var mutilPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
        self.titleLabel.theme_textColor = globalTextColorPicker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessage(_ storyModel: StoryModel) -> Void {
        self.titleLabel.text = storyModel.title
        if storyModel.images.count == 0 {
            self.pictureView.image = UIImage.init(named: "default_image")
        }
        else {
            self.pictureView.sd_setImage(with: URL.init(string: storyModel.images[0]), placeholderImage: UIImage.init(named: "default_image"))
        }
        self.mutilPicture.isHidden = !storyModel.multipic
    }
    
    func setFavoriteMessage(_ storyDetailModel: StoryDetailModel) -> Void {
        self.titleLabel.text = storyDetailModel.title
        self.pictureView.sd_setImage(with: URL.init(string: storyDetailModel.images[0]), placeholderImage: UIImage.init(named: "default_image"))
        self.mutilPicture.isHidden = true
    }
    
}
