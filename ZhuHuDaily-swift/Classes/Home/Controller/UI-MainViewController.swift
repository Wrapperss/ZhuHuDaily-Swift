//
//  UI-MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/14.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

extension MainViewController {
    
    // MARK: - UI  
    func setFakeNav() -> Void {
        self.fakeNav.slideAction = { () -> Void in
            self.viewDeckController?.open(.left, animated: true)
            let userDefaults = UserDefaults.standard
            let offsetDictionary: Dictionary = ["x" : self.tableView.contentOffset.x, "y" : self.tableView.contentOffset.y]
            userDefaults.setValue(offsetDictionary, forKey: "homeOffset")
        }
        self.view.addSubview(fakeNav)
    }
    
    func setTableView() -> Void {
        self.tableView.frame = CGRect.init(x: 0, y: -20, width: APP_WIDTH, height: APP_HEIGHT + 20)
        self.tableView.theme_separatorColor = ["#C6C5C5", "#ECF0F1"]
        self.tableView.register(UINib.init(nibName: "StoryViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setHeadView()
        self.view.addSubview(tableView)
    }
    
    func setHeadView() -> Void {
        if (CacheTool.shared.getTopStory()) != nil {
            self.topStoryArray = CacheTool.shared.getTopStory()!
        }
        headView.setStoryRotateView(topStoryArray: self.topStoryArray, heigit: HEAD_VIEW_HEIGHT)
        headView.delegate = self
        self.tableView.tableHeaderView = headView
    }
}
