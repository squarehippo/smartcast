//
//  PageViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/17/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var cityNames = ["Hillsborough, NC", "Traverse City, MI", "Aspen, CO", "Seattle, WA", "London, England", "Buffalo, NY"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("3. page view controller view did load")
        
        dataSource = self
        
        if let startingViewController = viewControllerAtIndex(0) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
            
            
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ViewController).index
        index++
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ViewController).index
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> ViewController? {
        
        print("4. page view controller at index - sending variables to view controller...")
        
        if index == NSNotFound || index < 0 || index >= cityNames.count {
            return nil
        }
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController {
            
            pageContentViewController.cityName = cityNames[index]
            pageContentViewController.index = index
            pageContentViewController.indexCount = cityNames.count
            
            
            
            return pageContentViewController
        }
        
        return nil
    }
    
    
    
}
