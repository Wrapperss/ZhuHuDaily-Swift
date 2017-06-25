//
//  SettingViewController.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/20.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit
import YYCache
import SVProgressHUD
import UserNotifications
import SwiftTheme

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PickViewControllerDelegate {

    let menuTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: APP_WIDTH, height: APP_HEIGHT), style: .grouped)
    
    var dateString = "8：00"
    var hour = ""
    var minute = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.theme_backgroundColor = ["#E6E7ED", "#1D1E28"]
        self.title = "设置"
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.theme_backgroundColor = ["#E6E7ED", "#1D1E28"]
        menuTableView.theme_separatorColor = ["#C6C5C5", "#ECF0F1"]
        self.view.addSubview(menuTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 计算总缓存的大小
    func cacheTotalCost() -> Int {
        let storyCache = YYCache.init(name: "storyCache")
        let storyDetailCache = YYCache.init(name: "storyDetailCache")
        let themArrayCache = YYCache.init(name: "themArrayCache")
        
        let totalCost = storyCache!.diskCache.totalCost() + storyDetailCache!.diskCache.totalCost() + themArrayCache!.diskCache.totalCost()
        return totalCost/1024
    }
    
    //
    func getDate(_ date: Date) {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "HH：mm"
        dateString = formatter.string(from: date)
        self.menuTableView.reloadData()
        formatter.dateFormat = "HH"
        self.hour = formatter.string(from: date)
        formatter.dateFormat = "mm"
        self.minute = formatter.string(from: date)
    }
    
    // 清理缓存
    func cleanAllCache() -> Void {
        SVProgressHUD.show(withStatus: "清除中")
        let storyCache = YYCache.init(name: "storyCache")
        let storyDetailCache = YYCache.init(name: "storyDetailCache")
        let themArrayCache = YYCache.init(name: "themArrayCache")
        
        storyCache?.diskCache.removeAllObjects()
        storyDetailCache?.diskCache.removeAllObjects()
        themArrayCache?.diskCache.removeAllObjects()
        self.menuTableView.reloadData()
        SVProgressHUD.showSuccess(withStatus: "清除完成")
    }
    
    // Swich Action
    func switchAction(sender: UISwitch) -> Void {
        let isButtonOn = sender.isOn
        UserDefaults.standard.set(isButtonOn, forKey: "isPushOn")
        let cell: UITableViewCell = self.menuTableView.cellForRow(at: IndexPath.init(row: 1, section: 0))!
        if isButtonOn {
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
            //创建推送
            let components = NSDateComponents.init()
            components.hour = Int(self.hour) == nil ? 8 : Int(self.hour)!
            components.minute = Int(self.minute) == nil ? 0 : Int(self.minute)!
            let calendarTrigger = UNCalendarNotificationTrigger.init(dateMatching: components as DateComponents, repeats: true)
            let content = UNMutableNotificationContent.init()
            content.title = "通知标题"
            content.subtitle = "通知副标题"
            content.body = "通知 body";
            content.badge = 1;
            content.sound = UNNotificationSound.default()
            let identifier = "ddd"
            
            let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: calendarTrigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: { (error) in
                if error == nil {
                    print("推送成功")
                }
            })
        }
        else {
            let cell: UITableViewCell = self.menuTableView.cellForRow(at: IndexPath.init(row: 1, section: 0))!
            cell.textLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.textColor = UIColor.lightGray
            //取消推送
            let center = UNUserNotificationCenter.current()
            center.removeDeliveredNotifications(withIdentifiers: ["ddd"])
        }
        
    }
    
    // switch Night Model
    func switchToNight(sender: UISwitch) -> Void {
        if MyThemes.isNight() {
            MyThemes.switchNight(isToNight: false)
            defaults.set(false, forKey: "isNight")
        }
        else {
            MyThemes.switchNight(isToNight: true)
            defaults.set(true, forKey: "isNight")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        if section == 2 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "通知"
        case 1:
            return "点击可清除缓存"
        case 2:
            return "色彩调节"
        default:
            return "关于我们"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "menuCell")
                cell.textLabel?.text = "是否需要每天发通知"
                cell.textLabel?.theme_textColor = globalTextColorPicker
                let switchView = UISwitch.init(frame: CGRect.zero)
                switchView.isOn = UserDefaults.standard.object(forKey: "isPushOn") as! Bool
                switchView.addTarget(self, action: #selector(switchAction(sender:)), for: .touchUpInside)
                cell.accessoryView = switchView
                cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
                return cell
            case 1:
                let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "menuCell")
                cell.textLabel?.text = "推送时间"
                cell.textLabel?.theme_textColor = globalTextColorPicker
                cell.detailTextLabel?.text = dateString
                cell.detailTextLabel?.theme_textColor = globalTextColorPicker
                if UserDefaults.standard.object(forKey: "isPushOn") as! Bool {
                    cell.textLabel?.textColor = UIColor.black
                    cell.detailTextLabel?.textColor = UIColor.black
                }
                else {
                    cell.textLabel?.textColor = UIColor.lightGray
                    cell.detailTextLabel?.textColor = UIColor.lightGray
                }
                cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
                return cell
            default:
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "menuCell")
                cell.textLabel?.text = "测试"
                cell.textLabel?.theme_textColor = globalTextColorPicker
                cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
                return cell
            }
        case 1:
            let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cacheCell")
            cell.textLabel?.text = "缓存"
            cell.textLabel?.theme_textColor = globalTextColorPicker
            cell.detailTextLabel?.text = "\(self.cacheTotalCost()) KB"
            cell.detailTextLabel?.theme_textColor = globalTextColorPicker
            cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
            return cell
        case 2:
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "menuCell")
            cell.textLabel?.theme_textColor = globalTextColorPicker
            cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
            if indexPath.row == 0  {
                cell.textLabel?.text = "夜间模式"
                let switchView = UISwitch.init(frame: CGRect.zero)
                switchView.isOn = defaults.object(forKey: "isNight") as! Bool
                switchView.addTarget(self, action: #selector(switchToNight(sender:)), for: .touchUpInside)
                cell.accessoryView = switchView
            }
            else {
                cell.textLabel?.text = "选择主题"
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        default:
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "menuCell")
            cell.textLabel?.text = "缓存"
            cell.textLabel?.theme_textColor = globalTextColorPicker
            cell.theme_backgroundColor = ["#FEFEFE", "#1D1E28"]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                // pick View
                let pickVC = pickViewController.init(nibName: "pickViewController", bundle: nil)
                pickVC.delegate = self
                pickVC.modalPresentationStyle = .custom
                self.present(pickVC, animated: true, completion: nil)
            case 2:
                let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 2.0, repeats: false)
                let content = UNMutableNotificationContent.init()
                content.title = "通知标题"
                content.subtitle = "通知副标题"
                content.body = "通知 body";
                content.badge = 1;
                content.sound = UNNotificationSound.default()
                let identifier = "LocaNotation"
                
                let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                center.add(request, withCompletionHandler: { (error) in
                    if error == nil {
                        print("推送成功")
                    }
                })
            default:
                break
            }
        case 1:
            self.cleanAllCache()
        default: break
            
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let edg = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.separatorInset = edg
    }
}
