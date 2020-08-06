//
//  ProfileViewController.swift
//  TabBarExample
//
//  Created by Winky_swl on 4/6/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.tabBarItem.selectedImage = UIImage(named: "ProfileClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.tabBarItem.image = UIImage(named: "Profile")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
 
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
