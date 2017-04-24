//
//  DetailViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/15.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UIViewController {
    
    var detailStoryModel: StoryDetailModel = StoryDetailModel() {
        didSet {
            self.webView.loadHTMLString(detailStoryModel.body.appending("<link rel=\"stylesheet\" type=\"text/css\" href=\"\(detailStoryModel.css[0]))\">"), baseURL: nil)
            self.coverView.sd_setImage(with: URL.init(string: detailStoryModel.image), placeholderImage: UIImage.init(named: "default_image"))
            SVProgressHUD.dismiss()
        }
    }
    
    var webView = UIWebView()
    var coverView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMsgForDetail(_ id: String) -> Void {
        self.loadStoryDetail(id)
    }

    
    // MARK - UI
    func setUl() -> Void {
        //webView
        webView.frame = CGRect.init(x: 0, y: -20, width: APP_WIDTH, height: APP_HEIGHT + 20)
        self.view.addSubview(webView)
        
        //imageView
        coverView.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: APP_HEIGHT * 0.3)
        self.webView.scrollView.addSubview(coverView)
    }
    
    // MARK - LoadStory
    private func loadStoryDetail(_ id: String) -> Void {
        SVProgressHUD.show(withStatus: "加载中~")
        if CacheTool.shared.getStoryDetail(id: id) != nil {
            self.detailStoryModel = CacheTool.shared.getStoryDetail(id: id)!
        }
        else {
            NetworkTool.shared.loadDateInfo(urlString: STORY_DETAIL_API.appending(id), params: ["":""], success: { (responseObject) in
                self.detailStoryModel = StoryDetailModel.mj_object(withKeyValues: responseObject)
                CacheTool.shared.setStoryDetail(self.detailStoryModel)
            }) { (error) in
                SVProgressHUD.showError(withStatus: "加载失败!")
            }

        }
    }
}
