//
//  CharacterChangeController.swift
//  Peng
//
//  Created by Yannick Schuchmann on 20.10.15.
//  Copyright © 2015 Yannick Schuchmann. All rights reserved.
//

import Foundation
import UIKit

class CharacterChangeViewController: UIViewController, UIPageViewControllerDataSource {
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    @IBOutlet weak var saveButton: UIButton!
    
    // Initialize it right away here
    private let characters = ["medic", "spasti", "fufeli", "hippie"];
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("CharacterChangeViewController") as! UIPageViewController
        pageController.dataSource = self
        
        if characters.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers((startingViewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height - 50)
        
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        self.view.bringSubviewToFront(self.saveButton)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        let light : UIColor = UIColor(red: 255/255.0, green: 249/255.0, blue: 238/255.0, alpha: 1)
        let bgRed : UIColor = UIColor(red: 109/255.0, green: 36/255.0, blue: 28/255.0, alpha: 1)
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = light
        appearance.backgroundColor = bgRed
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! CharacterChangeItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! CharacterChangeItemController
        
        if itemController.itemIndex+1 < characters.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> CharacterChangeItemController? {
        
        if itemIndex < characters.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("CharacterChangeItemController") as! CharacterChangeItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.character = characters[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return characters.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    

}