//
//  StoryViewCell.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/7.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SDWebImage

class StoryViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var mutilPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMessage(_ storyModel: StoryModel) -> Void {
        self.titleLabel.text = storyModel.title;
        self.pictureView.sd_setImage(with: URL.init(string: storyModel.images[0]), placeholderImage: UIImage.init(named: "default_image"))
        self.mutilPicture.isHidden = !storyModel.multipic
    }
}
