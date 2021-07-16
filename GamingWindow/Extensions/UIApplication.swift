//
//  UIApplication.swift
//  GamingWindow
//
//  Created by p-x9 on 2021/07/07.
//  
//

import UIKit

//https://github.com/Tencent/QMUI_iOS/issues/617
extension UIApplication{
    var providerClassName:String?{
        let window = UIApplication.shared.windows.first{
            $0.isKeyWindow
        }
        guard let keyWindow = window,
              let windowScene = keyWindow.windowScene,
              let manager = windowScene.statusBarManager else{
            return nil
        }
        guard manager.responds(to: Selector(("createLocalStatusBar"))),
              let statusBarWrap = manager.perform(Selector(("createLocalStatusBar"))).takeUnretainedValue() as? UIView else {
            return nil
        }
        guard statusBarWrap.responds(to: Selector(("statusBar"))),
              let statusBar = statusBarWrap.perform(Selector(("statusBar"))).takeUnretainedValue() as? UIView else {
            return nil
        }
        guard statusBar.responds(to: Selector(("statusBar"))),
              let _statusBar = statusBar.perform(Selector(("statusBar"))).takeUnretainedValue() as? UIView else {
            return nil
        }
        //let provider = _statusBar?.value(forKey: "visualProvider")
        //let providerClass = _statusBar?.value(forKey: "_visualProviderClass") as? AnyClass
        if _statusBar.responds(to: Selector(("_visualProviderClassName"))){
            return _statusBar.value(forKey: "_visualProviderClassName") as? String
        }
        return nil
    }
}

