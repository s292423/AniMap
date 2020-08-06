//
//  SecondViewController.swift
//  TabBarExample
//
//  Created by Winky_swl on 2/6/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.tabBarItem.selectedImage = UIImage(named: "SearchClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.tabBarItem.image = UIImage(named: "Search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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

