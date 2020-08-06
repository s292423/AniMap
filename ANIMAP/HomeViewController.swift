//
//  FirstViewController.swift
//  TabBarExample
//
//  Created by Winky_swl on 2/6/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        //Set tabBarItem image
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "HomeClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "Home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    
        let logo = UIImage(named: "ANIMAP Icon")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let right_menu_button = UIBarButtonItem(image: UIImage(named: "list")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                       style: UIBarButtonItemStyle.plain ,
                                       target: self, action: #selector(OnMenuClicked(sender:)))
        
        self.navigationItem.rightBarButtonItem = right_menu_button
        
        let left_menu_button = UIBarButtonItem(image: UIImage(named: "choice")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(OnMenuClicked(sender:)))
        
        self.navigationItem.leftBarButtonItem = left_menu_button
        
        self.tabBarController?.tabBar.barTintColor = UIColor.white
        self.tabBarController?.tabBar.isTranslucent = false
//        UITabBar.appearance().barTintColor = UIColor.black

    }
    
    func OnMenuClicked(sender: UIButton!) {
        print("123")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

