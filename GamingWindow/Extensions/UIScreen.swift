//
//  UIScreen.swift
//  GamingWindow
//
//  Created by p-x9 on 2021/07/07.
//  
//

import UIKit

extension UIScreen {
    private static let cornerRadiusKey: String = {
        let components = ["Radius", "Corner", "display", "_"]
        return components.reversed().joined()
    }()
    public var displayCornerRadius: CGFloat {
        guard let cornerRadius = self.value(forKey: Self.cornerRadiusKey) as? CGFloat else {
            return 0
        }
        
        return cornerRadius
    }
    
    private static let notchBottomCornerRadiusKey: String = {
        let components = ["Radius", "Corner", "Bottom","notch"]
        return components.reversed().joined()
    }()
    public var notchBottomCornerRadius:CGFloat{
        guard let className = UIApplication.shared.providerClassName,
              let providerClass = NSClassFromString(className) as? NSObject.Type,
              providerClass.responds(to: Selector(UIScreen.notchBottomCornerRadiusKey)),
              let notchBottomCornerRadius = providerClass.value(forKey: UIScreen.notchBottomCornerRadiusKey) as? CGFloat  else {
            return 0
        }
        
        return notchBottomCornerRadius
    }
    
    private static let notchTopCornerRadiusKey: String = {
        let components = ["Radius", "Corner", "Top","notch"]
        return components.reversed().joined()
    }()
    public var notchTopCornerRadius:CGFloat{
        guard let className = UIApplication.shared.providerClassName,
              let providerClass = NSClassFromString(className) as? NSObject.Type,
              providerClass.responds(to: Selector(UIScreen.notchTopCornerRadiusKey)),
              let notchTopCornerRadius = providerClass.value(forKey: UIScreen.notchTopCornerRadiusKey) as? CGFloat  else {
            return 0
        }
        
        return notchTopCornerRadius
    }
    
    private static let notchSizeKey: String = {
        let components = ["Size","notch"]
        return components.reversed().joined()
    }()
    public var notchSize:CGSize{
        guard let className = UIApplication.shared.providerClassName,
              let providerClass = NSClassFromString(className),
              providerClass.responds(to: Selector(UIScreen.notchSizeKey)) else{
            return .zero
        }
        
        return providerClass.value(forKey: UIScreen.notchSizeKey) as! CGSize
    }
}

