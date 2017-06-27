//
//  FavoriteViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/20.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
import Masonry
import SwiftTheme

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var favoriteStoryArray: [StoryDetailModel] {
        get {
            return CacheTool.shared.getAllFavoriteStory()
        }
    }
    
    let favoriteTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let titleView = FakeNavView.init(title: "我的收藏", isShowSlidButton: true)
        titleView.slideAction = { () -> Void in
            self.viewDeckController?.open(.left, animated: true)
        }
        self.view.addSubview(titleView)
        self.navigationController?.navigationBar.isHidden = true
        
        let titleLabel = UILabel.init()
        titleLabel.numberOfLines = 2
        titleLabel.text = "还没有任何收藏\n快去添加一点吧！"
        titleLabel.textColor = UIColor.lightGray
        self.view.addSubview(titleLabel)
        titleLabel.mas_makeConstraints({ (make) in
            make?.centerX.equalTo()(self.view)
            make?.centerY.equalTo()(self.view)
        })
        favoriteTableView.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
        //判断是否已经添加了收藏，如果没有收藏则不显示tableView
        if favoriteStoryArray.count != 0 {
            //tableview
            favoriteTableView.frame = CGRect.init(x: 0, y: 64, width: APP_WIDTH, height: APP_HEIGHT)
            favoriteTableView.tableFooterView = UIView()
            favoriteTableView.delegate = self
            favoriteTableView.dataSource = self
            favoriteTableView.register(UINib.init(nibName: "StoryViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
            self.view.addSubview(favoriteTableView)
            
            //refresh
            favoriteTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                SVProgressHUD.show(withStatus: "刷新中~")
                self.favoriteTableView.reloadData()
                SVProgressHUD.showSuccess(withStatus: "刷新成功！")
                self.favoriteTableView.mj_header.endRefreshing()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.favoriteTableView.reloadData()
        if self.favoriteStoryArray.count == 0 {
            self.favoriteTableView.removeFromSuperview()
        }
    }
    //  MARK - TableView Delegate DateSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteStoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "storyCell"
        let cell: StoryViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! StoryViewCell
        cell.setFavoriteMessage(self.favoriteStoryArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = DetailViewController()
        detailVc.setMsgForDetail(self.favoriteStoryArray[indexPath.row].id)
        self.navigationController?.pushViewController(detailVc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "取消收藏"
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        SVProgressHUD.show(withStatus: "删除中")
        CacheTool.shared.deleteFavorite(self.favoriteStoryArray[indexPath.row].id)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //favoriteTableView.reloadData()
        SVProgressHUD.showSuccess(withStatus: "删除成功")
        if self.favoriteStoryArray.count == 0 {
            self.favoriteTableView.removeFromSuperview()
        }
    }
}
