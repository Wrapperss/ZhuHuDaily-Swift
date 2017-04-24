//
//  DateTool.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/13.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import UIKit

class DateTool {

    //单例
    static let shared = DateTool()
    let weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
    private init(){}
    
    func transfromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd "
        
        let week = weeks[date.resultWeek()]
        
        return formatter.string(from:)(date).appending(week)
    }
    
    func transfromDateToApi(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYYMMdd"
        return formatter.string(from:)(date)
        
    }
}
