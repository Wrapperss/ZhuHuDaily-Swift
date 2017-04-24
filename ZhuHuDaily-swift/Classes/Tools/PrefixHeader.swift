//
//  PrefixHeader.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

//屏幕尺寸
let APP_SCREEN = UIScreen.main.bounds

//屏幕宽度
let APP_WIDTH = APP_SCREEN.size.width

//屏幕高度
let APP_HEIGHT = APP_SCREEN.size.height
//主题颜色
let ZHI_HU_COLOR = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
//NavigationBar高度
let NAVBAR_CHANGE_POINT = 50
//最新的故事Api
let LATEST_STORY_API = "http://news-at.zhihu.com/api/4/news/latest"
//之前的故事Api
let BEFORE_STORY_API = "http://news-at.zhihu.com/api/4/news/before/"
//故事详情Api
let STORY_DETAIL_API = "http://news-at.zhihu.com/api/4/news/"
//headView高度
let HEAD_VIEW_HEIGHT = APP_HEIGHT * 0.3
//sectionhead高度
let SECTION_VIEW_HEIGHT = CGFloat.init(44)
