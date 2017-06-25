//
//  CommentViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/18.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import MJExtension
import SVProgressHUD
import MJRefresh
import SwiftTheme

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var id = "" {
        didSet {
            self.longAPI = id.appending("/long-comments")
            self.shorAPI = id.appending("/short-comments")
        }
    }
    var longAPI = ""
    var shorAPI = ""
    
    var longCommentArray = [CommentModel]()
    var shortCommentArray = [CommentModel]()
    
    var tableView = UITableView()
    
    var expandedIndexpaths:[IndexPath]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        self.loadComment()
        
        self.setRefresh()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UI
    private func setUpUI() -> Void {
        self.view.theme_backgroundColor = globalBackgroundColorPicker
        
        // Fake NavigationBar
        let fakeNav = FakeNavView.init(title: "查看评论", isShowSlidButton: false)
        fakeNav.frame = CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: 64)
        self.view.addSubview(fakeNav)
        
        // Back Button
        let backButton = UIButton()
        backButton.setTitle("返回", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backButton.setImage(UIImage.init(named: "back"), for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitleColor(UIColor.gray, for: .highlighted)
        backButton.frame = CGRect.init(x: -10, y: 20, width: 100, height: 44)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0)
        backButton.contentHorizontalAlignment = .left
        backButton.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        expandedIndexpaths = []
        
        // Main TableView
        tableView.frame = CGRect.init(x: 0, y: 64, width: APP_WIDTH, height: APP_HEIGHT - 64)
        tableView.theme_backgroundColor = globalBackgroundColorPicker
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "LongCommentCell", bundle: nil), forCellReuseIdentifier: "LongCommentCell")
        tableView.register(UINib.init(nibName: "ShortCommentCell", bundle: nil), forCellReuseIdentifier: "ShortCommentCell")
        //给cell预估一个行高，达到cell动态改变高度的目的
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView.init()
        self.view.addSubview(tableView)
    }
    func backButtonClick() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK - LoadComment
    private func loadComment() -> Void {
        SVProgressHUD.show(withStatus: "加载中")
        NetworkTool.shared.loadDateInfo(urlString: COMMENT_API.appending(longAPI), params: ["":""], success: { (responseObject) in
            self.longCommentArray = CommentModel.mj_objectArray(withKeyValuesArray: responseObject["comments"]) as! [CommentModel]
            self.tableView.reloadData()
        }) { (error) in
            SVProgressHUD.showError(withStatus: "加载失败")
        }
        
        NetworkTool.shared.loadDateInfo(urlString: COMMENT_API.appending(shorAPI), params: ["":""], success: { (responseObject) in
            self.shortCommentArray = CommentModel.mj_objectArray(withKeyValuesArray: responseObject["comments"]) as! [CommentModel]
            self.tableView.reloadData()
        }) { (error) in
            SVProgressHUD.showError(withStatus: "加载失败")
        }
        SVProgressHUD.dismiss()
    }
    
    private func setRefresh() -> Void {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadComment()
            self.tableView.mj_header.endRefreshing()
        })
    }
    
    // MARK - TableView delegate dateSouce
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "长评论"
        }
        else {
            return "短评论"
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.longCommentArray.count == 0 ?  1 : self.longCommentArray.count
        }
        else {
            return self.shortCommentArray.count == 0 ? 1 : self.shortCommentArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if longCommentArray.count == 0 {
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "defaultCell")
                cell.textLabel?.text = "暂无长评论"
                cell.textLabel?.theme_textColor = globalTextColorPicker
                cell.theme_backgroundColor = globalBackgroundColorPicker
                //cell.tintColor = UIColor.lightGray
                cell.textLabel?.textColor = UIColor.lightGray
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
            else {
                let cell: LongCommentCell = tableView.dequeueReusableCell(withIdentifier: "LongCommentCell") as! LongCommentCell
                cell.setLongComment(longCommentArray[indexPath.row])
                cell.selectionStyle = .none
                
                if  expandedIndexpaths.contains(indexPath) {
                    cell.expanded  = true
                }else {
                    cell.expanded  = false
                }

                cell.expandClosure = {() -> Void in
                    if !cell.expanded! {
                        self.expandedIndexpaths.append(indexPath)
                    }else{
                        let index = self.expandedIndexpaths.index(of: indexPath)
                        self.expandedIndexpaths.remove(at: index!)
                    }
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                return cell
            }
        }
        else {
            if shortCommentArray.count == 0 {
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "defaultCell")
                cell.textLabel?.text = "暂无短评论"
                cell.theme_backgroundColor = globalBackgroundColorPicker
                cell.textLabel?.theme_textColor = globalTextColorPicker
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
            else {
                let cell: ShortCommentCell = tableView.dequeueReusableCell(withIdentifier: "ShortCommentCell") as! ShortCommentCell
                cell.setShorComment(shortCommentArray[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
        }
        
    }    
    
    //cell之间的分隔线居中
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
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
