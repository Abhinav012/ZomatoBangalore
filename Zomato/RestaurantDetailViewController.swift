//
//  RestaurantDetailViewController.swift
//  Zomato
//
//  Created by Abhinav Verma on 26/10/17.
//  Copyright © 2017 Abhinav Verma. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var restaurant : Restaurant? = nil
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    override func viewDidAppear(_ animated: Bool) {
        name.text! = selectedRestaurant!.name
        address.text! = selectedRestaurant!.address
        image.image = self.getImageFromImageURL()!
        
    }
    
    
    func getImageFromImageURL() ->UIImage?
    {
        let url = URL(string: selectedRestaurant!.imageURL)
        var imgData = Data()
        do
        {
        imgData = try Data(contentsOf: url!)
    
        }catch(let error)
        {
          print(error.localizedDescription)
        }
    
        
        return UIImage(data: imgData)
    }

   
}
