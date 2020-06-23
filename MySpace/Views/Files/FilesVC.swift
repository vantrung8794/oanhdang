//
//  FilesVC.swift
//  MySpace
//
//  Created by Trung Nguyen on 6/15/20.
//  Copyright © 2020 Trung Nguyen. All rights reserved.
//

import UIKit

class FilesVC: BaseVC{
    
    @IBOutlet weak var containerView: UIView!
    
    var viewControllers: [UIViewController]!
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageController()
        FileContaintsVM.getListBucket(inVC: self)
    }
    
    override func setupGradientBackground() {
    }
    
    // MARK: - Functions
    private func setupPageController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        
        viewControllers = [
            ImageVC(),
            MusicVC(),
            FilesListVC()
        ]
        
        pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward, animated: true, completion: nil)
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        
        pageViewController!.view.frame = containerView.bounds
        pageViewController.didMove(toParent: self)
        
        
        for view in pageViewController.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    @IBAction func changValueSegmen(_ sender: UISegmentedControl) {
        pageViewController.setViewControllers([viewControllerAtIndex(sender.selectedSegmentIndex)!], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewController DataSource and Delegate
extension FilesVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == viewControllers.count {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
}

// MARK: - Helpers
extension FilesVC {
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if viewControllers.count == 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int {
        return viewControllers.index(of: viewController) ?? NSNotFound
    }
}
