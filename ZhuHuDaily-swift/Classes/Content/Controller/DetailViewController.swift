//
//  DetailViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/15.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UIViewController, UIScrollViewDelegate, ActionViewDelegate{
    
    var detailStoryModel: StoryDetailModel = StoryDetailModel() {
        didSet {
            self.webView.loadHTMLString(detailStoryModel.body.appending("<link rel=\"stylesheet\" type=\"text/css\" href=\"\(detailStoryModel.css[0]))\">"), baseURL: nil)
            self.coverView.sd_setImage(with: URL.init(string: detailStoryModel.image), placeholderImage: UIImage.init(named: "default_image"))
            SVProgressHUD.dismiss()
        }
    }
    
    var webView = UIWebView()
    var coverView = UIImageView()
    var shareView = ShareView()
    var actionView = ActionView.init(frame: CGRect.init(x: 0, y: 0.92 * APP_HEIGHT, width: APP_WIDTH, height: 0.08 * APP_HEIGHT))
    
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
        
        webView.scrollView.delegate = self
        
        //imageView
        coverView.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: APP_HEIGHT * 0.27)
        coverView.contentMode = .scaleAspectFill
        coverView.clipsToBounds = true
        self.webView.scrollView.addSubview(coverView)
        
        //ActionView
        //actionView.frame = CGRect.init(x: 0, y: 0.92 * APP_HEIGHT, width: APP_WIDTH, height: 0.08 * APP_HEIGHT)
        actionView.delegate = self
        self.view.addSubview(actionView)
        
    }
    
    
    // MARK - ActionViewDelegate
    func commentButtonClick() -> Void {
        let bgView = UIView.init(frame: self.view.bounds)
        
        bgView.tag = 1
        
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        //bgView.alpha = 0.2
        self.view.addSubview(bgView)
        
        shareView.frame = CGRect.init(x: 0.2 * APP_WIDTH, y: -0.1 * APP_HEIGHT, width: 0.6 * APP_WIDTH, height: 0.4 * APP_HEIGHT)
        shareView.tag = 2
        bgView.addSubview(shareView)
        
        UIView.animate(withDuration: 1.0) {
            self.shareView.center.y = 0.4 * APP_HEIGHT
        }
        
        let tapGesturRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backToAirtity))
        bgView.addGestureRecognizer(tapGesturRecognizer)
    }
    
    func backToAirtity() -> Void {
        UIView.animate(withDuration: 1.0) { 
            self.shareView.center.y = 1.1 * APP_HEIGHT
        }
        for view in self.view.subviews {
            if view.tag == 1 {
                view.removeFromSuperview()
            }
        }
    }
    func shareButtonClick() -> Void {
        print("分享按钮")
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
    
    
    //头部放大
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            var frame = coverView.frame
            frame.origin.y = yOffset
            frame.size.height = -yOffset + 0.27 * APP_HEIGHT
            self.coverView.frame = frame
        }
    }
}
