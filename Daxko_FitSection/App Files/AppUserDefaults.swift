//
//  AppUserDefaults.swift
//  AppUserDefaults
//
//  Created by Sajal Gupta on 15/12/18.
//  Copyright © 2016 Sajal Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON

enum AppUserDefaults {
    
    static func value(forKey key: Key,
                      file : String = #file,
                      line : Int = #line,
                      function : String = #function) -> JSON {
        
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            
            debugPrint("No Value Found in UserDefaults\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
            
            return JSON.null
        }
        
        return JSON(value)
    }
    
    static func value<T>(forKey key: Key,
                      fallBackValue : T,
                      file : String = #file,
                      line : Int = #line,
                      function : String = #function) -> JSON {
        
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            
            debugPrint("No Value Found in UserDefaults\nFile : \(file) \nFunction : \(function)")
            return JSON(fallBackValue)
        }
        
        return JSON(value)
    }
    
    static func getFitShopLayoutStyle(forKey key: Key,
                                      fallBackValue: LayoutState,
                                      file : String = #file,
                                      line : Int = #line,
                                      function : String = #function) -> LayoutState {
        
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            save(value: fallBackValue.rawValue, forKey: .fitShopLayoutStyle)
            return fallBackValue
        }
        
        return LayoutState(value: (value as AnyObject).intValue)
    }
    
    static func save(value : Any, forKey key : Key) {
        
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeValue(forKey key : Key) {
        
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeAllValues() {
        
        let tutorialDisplayed = AppUserDefaults.value(forKey: .tutorialDisplayed).boolValue
        
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
        
        AppUserDefaults.save(value: tutorialDisplayed, forKey: .tutorialDisplayed)
    }
}

// MARK:- KEYS
//==============
extension AppUserDefaults {
    
    enum Key : String {
        
        case tutorialDisplayed
        case authorization
//        case accesstoken
        case fullUserProfile
        case fitShopLayoutStyle
    }
}
