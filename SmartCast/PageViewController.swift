//
//  PageViewController.swift
//  SmartCast
//
//  Created by Brian Wilson on 2/17/16.
//  Copyright © 2016 GetRunGo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var cityNames = ["Hillsborough, NC", "Traverse City, MI", "Sydney, Australia", "Aspen, CO", "Seattle, WA", "London, England", "Buffalo, NY"]
    let defaults = NSUserDefaults.standardUserDefaults()
    let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    
/*-------------------------------------------------------------------------------------------------------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets up app delegate which is used to refresh data when app returns from background
        appDelegate.myViewController = self
        appDelegate.currentIndex = defaults.integerForKey("currentIndex")

        //print("3. page view controller view did load")

        dataSource = self
        delegate = self
        
        if let startingViewController = viewControllerAtIndex(appDelegate.currentIndex!) {
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        
        let index = (pendingViewControllers[0] as! ViewController).index
        setDefaultsIndexValue(index)
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ViewController).index
        index++
        
        return viewControllerAtIndex(index)
    }

/*-------------------------------------------------------------------------------------------------------------*/
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ViewController).index
        index--
        
        return viewControllerAtIndex(index)
    }
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func viewControllerAtIndex(index: Int) -> ViewController? {
        
        //print("4. page view controller at index - sending variables to view controller...")
        
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
    
/*-------------------------------------------------------------------------------------------------------------*/
    
    func setDefaultsIndexValue(index: Int) {
        
        defaults.setValue(index, forKey: "currentIndex")
        //print("storing index value: \(index)")
        defaults.synchronize()
    }

/*-------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------*/
}
