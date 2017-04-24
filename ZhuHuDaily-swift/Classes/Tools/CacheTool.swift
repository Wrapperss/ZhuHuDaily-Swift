//
//  CacheTool.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/13.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import YYCache

class CacheTool {

    //单例
    static let shared = CacheTool()
    private init(){}
    
    let storyCache = YYCache.init(name: "storyCache")
    let storyDetailCache = YYCache.init(name: "storyDetailCache")
    
    // MARK - StoryCache
    
    //get
    func getStoryCacheBy(keyDate: Date) -> [StoryModel]? {
        let key = DateTool.shared.transfromDate(keyDate)
        return storyCache?.object(forKey: key) as? [StoryModel]
    }
    
    //set
    func setStoryCacheBy(ketDate: Date, AndObject object: [StoryModel]) -> Void {
        let key = DateTool.shared.transfromDate(ketDate)
        storyCache?.setObject(object as NSCoding, forKey: key)
    }
    
    //contain
    func containStoryCache(keyDate: Date) -> Bool {
        let key = DateTool.shared.transfromDate(keyDate)
        return (storyCache?.containsObject(forKey: key))!
        
    }
    
    // MARK - TopStoryCache
    
    // get
    func getTopStory() -> [TopStoryModel]? {
        return storyCache?.object(forKey: "topStory") as? [TopStoryModel]
    }
    
    // set
    func setTopStory(_ topStoryArray: [TopStoryModel]) -> Void {
        storyCache?.setObject(topStoryArray as NSCoding, forKey: "topStory")
    }
    
    // MARK - StoryDetailCache
    
    // set
    func getStoryDetail(id: String) -> StoryDetailModel? {
        return storyDetailCache?.object(forKey: id) as? StoryDetailModel
    }
    // get
    func setStoryDetail(_ storyDetailModel: StoryDetailModel) -> Void {
        storyDetailCache?.setObject(storyDetailModel, forKey: storyDetailModel.id)
    }
    
}
