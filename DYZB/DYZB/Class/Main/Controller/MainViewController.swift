//
//  MainViewController.swift
//  DYZB
//
//  Created by Chang on 10/27/16.
//
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllerbyName(storyName: "Home")
        addChildViewControllerbyName(storyName: "Live")
        addChildViewControllerbyName(storyName: "Follow")
        addChildViewControllerbyName(storyName: "Me")
    }
    
    
    
    private func addChildViewControllerbyName(storyName : String) {
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
        
    }
}
