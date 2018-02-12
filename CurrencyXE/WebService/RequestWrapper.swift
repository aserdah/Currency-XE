
import UIKit
import SwifterSwift
import MagicalRecord
import Alamofire
import SwiftyJSON
class RequestWrapper: NSObject {
    
    func getConvert(from : String , to : String, completionHandler: @escaping ((ConvertModel?) -> Void)) {
        let url = URL.init(string: "https://api.fixer.io/latest?base=\(from)&symbols=\(to))")
        
        Alamofire.request(url!, method: .get, parameters: ["from": "to"]).responseSwiftyJSON { response in
            print("# printing !!! : \(response.result.isSuccess)")
            
            completionHandler(ConvertModel.init(json: response.value!))
        }
        
}
}
