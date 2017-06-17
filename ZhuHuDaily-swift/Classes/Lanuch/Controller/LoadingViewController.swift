//
//  LoadingViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/10.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//因Api接口关闭，无法获取照片
//https://news-at.zhihu.com/api/7/prefetch-launch-images/1080*1920
//        NetworkTool.shared.loadDateInfo(urlString: LAUNCH_SCREEN_API, params: ["":""], success: { (responseObject) in
//                if let creatives = responseObject["creatives"] as? [Any] {
//                    if let array = creatives[0] as? [String : Any] {
//                        self.backgroundImage.sd_setImage(with: URL.init(string: array["url"] as! String))
//                    }
//                }
//        }) { (error) in
//            print(error)
//        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            UIApplication.shared.delegate?.window??.rootViewController = UINavigationController.init(rootViewController: MainViewController())
            UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
