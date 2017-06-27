//
//  ThemViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/20.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
import SVProgressHUD

class ThemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var themTableView = UITableView.init(frame: CGRect.init(x: 0, y: -20, width: APP_WIDTH, height: APP_HEIGHT + 20))
    
    let titleView = FakeNavView.init(title: "主题日报", isShowSlidButton: true)
    
    var themTitleArray = [ThemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        // LOAD THEM TITLE
        // 加载数据
        self.loadThemTitle()
        
        // TableView
        // 设置TableView
        themTableView.delegate = self
        themTableView.dataSource = self
        themTableView.register(UINib.init(nibName: "ThemCell", bundle: nil), forCellReuseIdentifier: "themCell")
        themTableView.tableFooterView = UIView.init()
        themTableView.separatorStyle = .none
        themTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadThemTitle()
            self.themTableView.mj_header.endRefreshing()
        })
        
        self.view.addSubview(themTableView)
        
        // TitleView
        // 通过block传递方法
        titleView.slideAction = { () -> Void in
            self.viewDeckController?.open(.left, animated: true)
        }
        self.view.addSubview(titleView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK - Load Them Titlte
    func loadThemTitle() -> Void {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.show(withStatus: "加载中")
        NetworkTool.shared.loadDateInfo(urlString: THEM_TITLE_API, params: ["":""], success: { (responseObject) in
            self.themTitleArray = ThemModel.mj_objectArray(withKeyValuesArray: responseObject["others"]) as! [ThemModel]
            CacheTool.shared.setThemArray(self.themTitleArray)
            self.themTableView.reloadData()
            SVProgressHUD.showSuccess(withStatus: "加载完成")
        }) { (error) in
            if CacheTool.shared.getThemArray() != nil {
                self.themTitleArray = CacheTool.shared.getThemArray()!
                self.themTableView.reloadData()
            }
            SVProgressHUD.showError(withStatus: "加载失败")
        }
    }
    
    // MARK - TableView Delegate DateSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "themCell"
        let cell: ThemCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ThemCell
        cell.setThemCell(self.themTitleArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let themDetailController = ThemDetailController()
        themDetailController.themModel = self.themTitleArray[indexPath.row]
        self.navigationController?.pushViewController(themDetailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = themTableView.contentOffset.y / 150
        self.titleView.backgroundColor = UIColor.colorWithZhuHu(alpha: alpha)
        if alpha > 1 {
            self.titleView.titleLabel.shadowColor = UIColor.clear
        }
        else {
            self.titleView.titleLabel.shadowColor = UIColor.lightGray
        }
    }
}
