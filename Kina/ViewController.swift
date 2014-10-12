//
//  ViewController.swift
//  Kina
//
//  Created by Mailo Svetel on 11/10/14.
//  Copyright (c) 2014 Mailo Svetel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMovies() {
        let net = Net(baseUrlString: "http://pipes.yahoo.com")
        let params = ["_id": "4de0bb303324b7fc764cae83e4c9abde", "_render": "json"]
        
        net.GET(
            "/pipes/pipe.run",
            params: params,
            successHandler: {
                responseData in let result = responseData.json(error: nil)
//                NSLog("result \(result)")
                
                let theValue = result!.objectForKey("value") as NSDictionary!
                let items = theValue!.objectForKey("items") as NSArray!
                
                let titleOne: NSString! = items[0].valueForKey("title") as NSString
                
                NSLog("\(titleOne)")
            },
            failureHandler: {
                error in NSLog("Error")
            }
        )
        
    }


}

