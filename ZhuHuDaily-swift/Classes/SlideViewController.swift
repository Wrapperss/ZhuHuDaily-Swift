//
//  SlideViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/20.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import Masonry
import SwiftTheme

class SlideViewController: UIViewController {
    
    var curentControllerIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.init(red: 38/255, green: 38/255, blue: 56/255, alpha: 1)
        self.view.theme_backgroundColor = globalBackgroundColorPicker
        
        //logo
        let logoImageView = UIImageView.init(image: UIImage.init(named: "launch_screen_logo"))
        logoImageView.frame = CGRect.init(x: 60, y: 80, width: APP_WIDTH * 0.28, height: APP_HEIGHT * 0.12)
        self.view.addSubview(logoImageView)
        
        //menuButtn
        for index in 0...3 {
            self.addMenuButton(index: index)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addMenuButton(index: Int) -> Void {
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 200 + CGFloat.init(index) * 60, width: 0.6 * APP_WIDTH, height: 40))
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(menuButtonClick(sender:)), for: .touchUpInside)
        switch index {
        case 0:
            button.setTitle("知乎日报", for: .normal)
            button.tag = 0
        case 1:
            button.setTitle("主题日报", for: .normal)
            button.tag = 1
        case 2:
            button.setTitle("我的收藏", for: .normal)
            button.tag = 2
        default:
            button.setTitle("设置", for: .normal)
            button.tag = 3
        }
        self.view.addSubview(button)
    }
    
    func menuButtonClick(sender: UIButton) -> Void {
        if sender.tag == curentControllerIndex {
            self.viewDeckController?.closeSide(true)
        }
        else {
            let userDefaultes = UserDefaults.standard
            
            switch sender.tag {
            case 0:
                let mainVC = MainViewController()
                mainVC.isNeedRefresh = false
                let offSetDictionary: [String : CGFloat] = userDefaultes.object(forKey: "homeOffset") as! [String : CGFloat]
                let offset: CGPoint = CGPoint.init(x: offSetDictionary["x"]!, y: offSetDictionary["y"]!)
                mainVC.offSet = offset
                self.viewDeckController?.centerViewController = UINavigationController.init(rootViewController: mainVC)
            case 1:
                self.viewDeckController?.centerViewController = UINavigationController.init(rootViewController: ThemViewController())
            case 2 :
                self.viewDeckController?.centerViewController = UINavigationController.init(rootViewController: FavoriteViewController())
            case 3:
                self.viewDeckController?.centerViewController = UINavigationController.init(rootViewController: SettingViewController())
            default:
                print("按钮被点击")
            }
            self.viewDeckController?.closeSide(true)
            self.curentControllerIndex = sender.tag
        }
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
