
//  Contries.swift
//  Hack
//
//  Created by MKD on 18/12/17.
//  Copyright © 2017 MKD. All rights reserved.
//

import Foundation
import CoreData
import AlamofireSwiftyJSON
import SwiftyJSON
import Alamofire


class ConvertModel: NSObject {

    
    var from :String!
    var to :String!
    var rate : Double!
    
    required init(json: JSON) {
        print(json)
        from = json["base"].stringValue
       to = json["rates"].dictionaryValue.keys.first?.nsString as! String
        rate = json["rates"].dictionaryValue.values.first?.double
        
    }
    
}

