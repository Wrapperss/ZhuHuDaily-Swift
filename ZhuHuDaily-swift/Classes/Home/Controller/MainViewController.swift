//
//  MainViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/6.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
import YYCache
import SVProgressHUD

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryRotateViewDelegate {

    var tableView = UITableView()
    var headView = StoryRotateView()
    var fakeNav = FakeNavView.init(title: "")
    
    var storyArray = [StoryModel]()
    var beforeStoryArray = [[StoryModel]]()
    var topStoryArray = [TopStoryModel]()
    var titleArray = [String]()
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.loadStory()
        self.setTableView()
        self.setFakeNav()
        self.setRefresh()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //  topView 点击事件
    func clickOneView(currentPage: Int) -> Void {
        self.pushDetailViewController(indexPath: nil, currentPage: currentPage)
    }
    
    // 加载新的 Controller
    func pushDetailViewController(indexPath: IndexPath?, currentPage: Int?) -> Void {
        let detailVC = DetailViewController()
        if indexPath == nil {
            if topStoryArray.count != 0 {
                detailVC.setMsgForDetail(topStoryArray[currentPage!].id)
            }
            else {
                return
            }
        }
        else {
            if self.storyArray.count != 0{
                detailVC.setMsgForDetail( (indexPath?.section)! == 0 ? storyArray[(indexPath?.row)!].id : (beforeStoryArray[((indexPath?.section)!-1)][(indexPath?.row)!].id) )
            }
            else {
                return
            }
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.beforeStoryArray.count == 0 && self.storyArray.count == 0 {
            return 2;
        }
        else {
            return self.beforeStoryArray.count + 1;
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.storyArray.count == 0 {
                if (YYCache.init(name: "stotriesCache")?.containsObject(forKey: String(describing: Date.init())))! {
                    storyArray = (YYCache.init(name: "stotriesCache")?.object(forKey: String(describing: Date.init())))! as! [StoryModel]
                }
                if self.storyArray.count == 0 {
                    return 10
                }
            }
            return self.storyArray.count
        }
        else {
            if self.beforeStoryArray.count == 0 {
                return 0
            }
            else {
                return self.beforeStoryArray[section-1].count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "storyCell"
        let cell: StoryViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! StoryViewCell
        let dateMark = Date.init(timeInterval: 24*60*60, since: Date())
        if indexPath.section == 0 {
            if storyArray.count == 0 {
                if CacheTool.shared.containStoryCache(keyDate: dateMark) {
                    self.storyArray = CacheTool.shared.getStoryCacheBy(keyDate: dateMark)!
                }
                else {
                    //空白的cell
                    cell.pictureView?.image = UIImage.init(named: "default_image")
                    cell.titleLabel.text = "知乎日报"
                    cell.mutilPicture.isHidden = true
                    return cell
                }
            }
            cell.setMessage(storyArray[indexPath.row])
        }
        else {
            cell.setMessage(self.beforeStoryArray[indexPath.section-1][indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : SECTION_VIEW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        else {
            let headView = TitleView()
            if self.titleArray.count == 0 {
                return nil
            }
            headView.setMessage(title: self.titleArray[section - 1])
            return headView
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushDetailViewController(indexPath: indexPath, currentPage: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
