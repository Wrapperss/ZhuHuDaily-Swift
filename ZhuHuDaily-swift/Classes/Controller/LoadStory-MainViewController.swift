//
//  Extension-MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/13.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

extension MainViewController {
    
    // MARK: - Refresh
    func setRefresh() -> Void {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadStory()
            self.tableView.mj_header.endRefreshing()
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.loadMoreStory()
            self.tableView.mj_footer.endRefreshing()
        })
    }
    
    // MARK: - LoadStory
    func loadStory() -> Void {
        let dateMark = Date.init(timeInterval: 24*60*60, since: Date())
        NetworkTool.shared.loadDateInfo(urlString: LATEST_STORY_API, params: ["":""], success: { (responseObject) in
            
            //最新故事
            self.storyArray.removeAll()
            for story in responseObject["stories"] as! Array<Any> {
                let storyModel: StoryModel = StoryModel.mj_object(withKeyValues: story)
                //UI
                self.storyArray.append(storyModel)
                
            }
            //Cache
            //缓存的key为日期的前一天，比如2017年04月19日的信息的key为20170420
            CacheTool.shared.setStoryCacheBy(ketDate: dateMark, AndObject: self.storyArray)
            
            
            //封面故事
            self.topStoryArray.removeAll()
            for topStory in responseObject["top_stories"] as! Array<Any> {
                let topStoryModel: TopStoryModel = TopStoryModel.mj_object(withKeyValues: topStory)
                if !self.topStoryArray.contains(topStoryModel) {
                    //UI
                    //Cache
                    self.topStoryArray.append(topStoryModel)
                }
            }
            CacheTool.shared.setTopStory(self.topStoryArray)
            self.headView.upDateView(self.topStoryArray)
            
            //重新加载tableview视图
            self.tableView.reloadData()
        }) { (error) in
            if CacheTool.shared.containStoryCache(keyDate: dateMark) {
                SVProgressHUD.showError(withStatus: "刷新失败!")
                self.storyArray = CacheTool.shared.getStoryCacheBy(keyDate: dateMark)!
                self.topStoryArray = CacheTool.shared.getTopStory()!
            }
            else {
                SVProgressHUD.showError(withStatus: "加载失败!")
            }
        }
    }
    
    // MARK - 加载更多消息
    func loadMoreStory() -> Void {
        if CacheTool.shared.containStoryCache(keyDate: self.date) {
            self.beforeStoryArray.append(CacheTool.shared.getStoryCacheBy(keyDate: self.date)!)
            self.setDate()
            self.tableView.reloadData()
        }
        else {
            NetworkTool.shared.loadDateInfo(urlString: BEFORE_STORY_API.appending(DateTool.shared.transfromDateToApi(self.date)), params: ["":""], success: { (responseObject) in
                var storyArray = [StoryModel]()
                for story in responseObject["stories"]  as! Array<Any>{
                    let storyModel: StoryModel = StoryModel.mj_object(withKeyValues: story)
                    storyArray.append(storyModel)
                }
                
                self.beforeStoryArray.append(storyArray)
                CacheTool.shared.setStoryCacheBy(ketDate: self.date, AndObject: storyArray)
                self.setDate()
                
                self.tableView.reloadData()
            }) { (error) in
                SVProgressHUD.showError(withStatus: "加载失败")
            }
        }
    }
    
    // MARK -  时间前置一天
    func setDate() -> Void {
        self.date = Date.init(timeInterval: -24*60*60, since: date)
        self.titleArray.append(DateTool.shared.transfromDate(self.date))
    }

}
