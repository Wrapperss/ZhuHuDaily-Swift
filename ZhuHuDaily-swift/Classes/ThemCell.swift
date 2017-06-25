//
//  ThemCell.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/22.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SDWebImage

class ThemCell: UITableViewCell {

    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setThemCell(_ themModel: ThemModel) -> Void {
        self.coverView.sd_setImage(with: URL.init(string: themModel.thumbnail), placeholderImage: UIImage.init(named: "default_image"))
        self.titleLabel.text = themModel.name
        self.descriptionLabel.text = themModel.descriptionText
    }
}
