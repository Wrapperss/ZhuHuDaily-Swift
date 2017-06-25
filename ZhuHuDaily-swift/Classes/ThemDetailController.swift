//
//  ThemDetailController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/23.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJRefresh
import MJExtension
import SVProgressHUD

class ThemDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var themModel: ThemModel?
    var storyArray = [StoryModel]()
    var storyTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        
        // load Story
        self.loadThemContent()
        
        // TitleView
        let titleView = FakeNavView.init(title: themModel!.name, isShowSlidButton: false)
        self.view.addSubview(titleView)
        
        // BackButton
        let backButton = UIButton.init(frame: CGRect.init(x: 10, y: 25, width: 30, height: 30))
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        //
        storyTableView.frame = CGRect.init(x: 0, y: 64, width: APP_WIDTH, height: APP_HEIGHT - 64)
        storyTableView.delegate = self
        storyTableView.dataSource = self
        storyTableView.tableFooterView = UIView()
        storyTableView.register(UINib.init(nibName: "StoryViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
        storyTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadThemContent()
            self.storyTableView.mj_header.endRefreshing()
        })
        self.view.addSubview(storyTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Load Them Content
    func loadThemContent() -> Void {
        SVProgressHUD.show(withStatus: "加载中")
        NetworkTool.shared.loadDateInfo(urlString: THEM_CONTENT_API.appending(self.themModel!.id), params: ["":""], success: { (responseObject) in
            self.storyArray = StoryModel.mj_objectArray(withKeyValuesArray: responseObject["stories"]) as! [StoryModel]
            self.storyTableView.reloadData()
            SVProgressHUD.showSuccess(withStatus: "加载完成")
        }) { (error) in
            SVProgressHUD.showError(withStatus: "加载失败")
        }
    }
    
    // Button Click
    func backButtonClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "storyCell"
        let cell: StoryViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! StoryViewCell
        
        cell.setMessage(self.storyArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.setMsgForDetail(self.storyArray[indexPath.row].id)
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
