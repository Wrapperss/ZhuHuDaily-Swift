//
//  MyThemes.swift
//  ZhuHuDaily-swift
//
//  Created by Wrappers Zhang on 2017/6/25.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

import Foundation
import SwiftTheme

private let lastThemeIndexKey = "lastedThemeIndex"


enum MyThemes : Int {
    case Nomal = 0
    case Night = 1
    
    static var current: MyThemes { return MyThemes(rawValue: ThemeManager.currentThemeIndex)! }
    static var before = MyThemes.Nomal
    
    static func switchTo(_ theme: MyThemes) {
        before  = current
        ThemeManager.setTheme(index: theme.rawValue)
    }
    
    static func switchNight(isToNight: Bool) {
        switchTo(isToNight ? .Night : .Nomal)
    }
    
    static func isNight() -> Bool {
        return current == .Night
    }
    
    static func restoreLastTheme() {
        switchTo(MyThemes(rawValue: defaults.integer(forKey: lastThemeIndexKey))!)
    }
    
    static func saveLastTheme() {
        defaults.set(ThemeManager.currentThemeIndex, forKey: lastThemeIndexKey)
    }
}
