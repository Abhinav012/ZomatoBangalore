//
//  JSONParsingResources.swift
//  Zomato
//
//  Created by Abhinav Verma on 26/10/17.
//  Copyright © 2017 Abhinav Verma. All rights reserved.
//

import UIKit

class JSONParsingResources: NSObject {
    
    
 static func gettingJSONParsingResources( urlString :String) -> (URLSession , URLRequest)
    {
        let url = URL(string: urlString)
        let urlRequest = NSMutableURLRequest(url: url!)
        let session = URLSession.shared
        
        urlRequest.addValue("39eda4fd49a5a8a2779654acc6633e43", forHTTPHeaderField: "user-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
         return (session, urlRequest as URLRequest)
    }
}
