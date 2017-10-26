//
//  MenuViewController.swift
//  Zomato
//
//  Created by Abhinav Verma on 26/10/17.
//  Copyright © 2017 Abhinav Verma. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingMenuDetails()
}
    
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    
    func gettingMenuDetails()
    {
        
        let (session, urlRequest) = JSONParsingResources.gettingJSONParsingResources(urlString: "https://developers.zomato.com/api/v2.1/dailymenu?res_id=\(String(describing: selectedRestaurant!.res_id))")

        let task = session.dataTask(with: urlRequest as URLRequest) {
        
        (data, response, error) in
        
        if error == nil
        {
             do
             {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
                
                print(jsonData)
            }
             catch(let error)
             {
              print(error.localizedDescription)
            
             }
        }
        
        }
        
     task.resume()
        
        
    }
    
    

   
}
