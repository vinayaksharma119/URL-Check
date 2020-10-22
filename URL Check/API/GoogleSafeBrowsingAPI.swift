//
//  GoogleSafeBrowsingAPI.swift
//  URL Check
//
//  Created by Vinayak Sharma on 22/10/20.
//

import Foundation
import SwiftyJSON
import Alamofire

class GoogleSafeBrowsingAPI {
    
    static func checkURLSafe(_ url: String, completion: @escaping (_ result: Bool?) -> Void ) {
       
        let client              = ["clientId":"URL-check", "clientVersion":"1.0"]
        let threatTypes         = ["MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE",
                                   "THREAT_TYPE_UNSPECIFIED"]
        let platformTypes       = ["ANY_PLATFORM"]
        let threatEntryTypes    = ["URL"]
        let threatEntries       = [["url":"\(url)"]]
        let threatInfo              = ["threatTypes":threatTypes, "platformTypes":platformTypes,
                                   "threatEntryTypes":threatEntryTypes, "threatEntries":threatEntries] as [String : Any]
        let paras               = ["client":client as AnyObject, "threatInfo":threatInfo as
                                    AnyObject]
        
        AF.request("https://safebrowsing.googleapis.com/v4/threatMatches:find?key=\(GoogleAPI.googleAPIKey)", method: .post,parameters: paras, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
            case .success:
                let result = JSON(response.value!).count == 0
                completion(result)
            
            case let .failure(error):
                print(error)
                completion(nil)
            }
        }
    }
    
}
