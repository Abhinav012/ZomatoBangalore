//
//  ReviewsViewController.swift
//  Zomato
//
//  Created by Abhinav Verma on 26/10/17.
//  Copyright © 2017 Abhinav Verma. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    var foodieReview = [Reviews]()
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        gettingReview()
    }
    
 func gettingReview()
 {
    let (session, urlRequest) = JSONParsingResources.gettingJSONParsingResources(urlString: "https://developers.zomato.com/api/v2.1/reviews?res_id=\(selectedRestaurant!.res_id)")
    
    let task = session.dataTask(with: urlRequest as URLRequest) {
        
        (data, response, error) in
        
        if error == nil
        {
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
                
                
                print(jsonData)
                
                let reviewData = jsonData["user_reviews"] as! NSMutableArray
                
                for review in reviewData
                {
                   let userReview = Reviews()
                    
                     let revDataArray = review as! [String : Any]
                     let reviewInfo = revDataArray["review"] as! [String : Any]
                    userReview.reviewText   = reviewInfo["review_text"] as! String
                    let userDetails = reviewInfo["user"] as! [String : Any]
                    userReview.nameOfFoodie = userDetails["name"] as! String
                    userReview.foodieImageURL = userDetails["profile_image"] as! String
                    
                    self.foodieReview.append(userReview)
                    
                    print(userReview.nameOfFoodie)
                
                    OperationQueue.main.addOperation {
                       self.reviewTableView.reloadData()
                        
                    }

                }
                
                
                
                
                
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

extension ReviewsViewController : UITableViewDelegate, UITableViewDataSource
{


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return (foodieReview.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewTableViewCell
        
        cell.nameLabel.text! = foodieReview[indexPath.row].nameOfFoodie
        cell.reviewLabel.text! = foodieReview[indexPath.row].reviewText
        cell.foodieImage.image = imageOfFoodie(review: foodieReview[indexPath.row])
        
        return cell
    }
    
  
    
    func  imageOfFoodie( review : Reviews)-> UIImage
  {
   
    let url = URL(string: review.foodieImageURL)
    var imgData = Data()
    do
    {
        imgData = try Data(contentsOf: url!)
        
    }catch(let error)
    {
        print(error.localizedDescription)
    }
    
    
    return UIImage(data: imgData)!
    
    
    
  }

}
