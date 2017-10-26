//
//  ViewController.swift
//  Zomato
//
//  Created by Abhinav Verma on 25/10/17.
//  Copyright © 2017 Abhinav Verma. All rights reserved.
//

import UIKit


var selectedRestaurant : Restaurant? = nil

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var RestaurantTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    self.getBangaloreRestaurantsDetails()
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress(_:)))
    longPressGesture.minimumPressDuration = 1.0 // 1 second press
    longPressGesture.delegate = self
    self.RestaurantTableView.addGestureRecognizer(longPressGesture)
        
     self.RestaurantTableView.allowsMultipleSelection = true
        
    
    }
    
    
    
    static var restaurantsDetailData : NSMutableArray? = nil
    static var restaurants : [Restaurant] = []
    static var selectedRowsId = [Int]()
    
    
    
     func getBangaloreRestaurantsDetails()
    {
        
      
      let (session, urlRequest) = JSONParsingResources.gettingJSONParsingResources(urlString: "https://developers.zomato.com/api/v2.1/search?entity_id=4&entity_type=city")
        

        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) in
            
            
            if error == nil
            {
                
                do
                {
                    
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
                    
                    ViewController.restaurantsDetailData = (jsonData["restaurants"] as! NSMutableArray)
                    
                    
                    
                    
                    for restaurantDetail in ViewController.restaurantsDetailData!       
                    {
                        
                        print(restaurantDetail)
                        
                        let rest = restaurantDetail as! NSDictionary
                        let restaurantInArray = rest["restaurant"]! as! NSDictionary
                        
                        let restaurant = Restaurant()
                        restaurant.name = restaurantInArray["name"]! as! String
                        restaurant.URLLink = restaurantInArray["url"]! as! String
                        let location = restaurantInArray["location"] as! [String : Any]
                        restaurant.address = location["address"] as! String
                        restaurant.imageURL = restaurantInArray["thumb"] as! String
                        
                        let R = restaurantInArray["R"] as! [String : Any]
                        restaurant.res_id = R["res_id"] as! Int
                        
                        print("Restaurant id is \(restaurant.res_id)")
                        
                        ViewController.restaurants.append(restaurant)
                        
                        print(restaurant.name)
                        
                        
                        OperationQueue.main.addOperation {
                        self.RestaurantTableView.reloadData()
                            
                        }
                     }
                    
                    
                    
                } catch(let err)
                {
                    print(err.localizedDescription)
                    
                }
            }
        }
        
        task.resume()
        
        
         }
    
    func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = RestaurantTableView.indexPathForRow(at: touchPoint) {
                
                print(ViewController.restaurants[indexPath.row].name)
                
                
                    RestaurantTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    ViewController.selectedRowsId.append(ViewController.restaurants[indexPath.row].res_id)
              
                    print(ViewController.selectedRowsId)
                }
            
            }
        }
    
    
    
    @IBAction func popupNumberofRowsSelected(_ sender: Any) {
        
        let alert = UIAlertController(title: "Number of Restaurant Selected ", message: "\(ViewController.selectedRowsId.count)", preferredStyle: UIAlertControllerStyle.alert)
        let oKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(oKAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    }
 
    



extension ViewController : UITableViewDelegate, UITableViewDataSource
{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.restaurants.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! TableViewCell
        
        let restaurant = ViewController.restaurants[indexPath.row]
        
        cell.restaurantName.text! = (restaurant.name)
        cell.restaurantURL.text!  = (restaurant.URLLink)
        
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantsView")
     
        selectedRestaurant = ViewController.restaurants[indexPath.row]
        present(viewController!, animated: true, completion: nil)
    }
    
    
    
}

