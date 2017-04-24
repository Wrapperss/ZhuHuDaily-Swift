//
//  Date-Extension.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/4/13.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import Foundation

extension Date{
    func resultWeek()->Int{
        let interval = self.timeIntervalSince1970
        let day = Int(interval/86400)
        return (day-3)%7
    }
}
