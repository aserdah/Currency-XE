//
//  UserDefaults.swift
//  UserDefaultsExample
//
//  Created by Training on 12/2/17.
//  Copyright © 2017 example. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    
    public struct Keys {
        static let s_access_token = "s_access_token"
    }
    
    // NSCoding
    
    var app_s_access_token: String! {
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.s_access_token)
        }
        get {
            return UserDefaults.standard.value(forKey: Keys.s_access_token) as? String
        }
    }
 
  
        
   
    
}


