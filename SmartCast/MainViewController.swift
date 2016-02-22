//
//  MainViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/17/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("1. assigning app delegate")
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //print("2. in main view controller, view did appear.  Headed to page view controller")
        if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
            presentViewController(pageViewController, animated: true, completion: nil)
            
        }
    }
    
    
}

