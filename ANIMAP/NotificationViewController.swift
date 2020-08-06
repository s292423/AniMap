//
//  NotificationViewController.swift
//  TabBarExample
//
//  Created by Winky_swl on 4/6/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mytableview: UITableView!
    let list = ["台中最好玩的地方", "台中哪間百貨公司好呢", "想要買到最好吃的鹽酥雞", "褲子鈕扣壞掉可以去哪裡修理啊", "走失小狗請幫忙協尋！！！","想不到了", "我想知道最酷的公司在哪裡"]
    
    let articleIDs = ["0","1","2","3","4","5","6"]
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
        
//        let vc = ArticleViewController(IDs: articleIDs[indexPath.row])
//        self.present(vc, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier :"Ar") as! ArticleTableViewController
        vc.id = list[indexPath.row]
        
        
        //thread issue
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
        
        

    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! QuestionTableViewCell
        cell.title.text = list[indexPath.row]
        cell.selectionStyle = .none
        
        let image = UIImage(named: "a\(indexPath.row)" + ".jpeg")
      
        let newImgThumb = UIImageView(frame:CGRect(x: 0, y: 0, width: cell.cardview.bounds.width, height: cell.cardview.bounds.height))
        newImgThumb.image = image
        newImgThumb.contentMode = .scaleAspectFill
        newImgThumb.layer.masksToBounds = true
        newImgThumb.layer.cornerRadius = 10
        newImgThumb.alpha = 0.6
       // newImgThumb.backgroundColor = .red


        
        cell.cardview.addSubview(newImgThumb)
        return cell
    }
    
    

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.tabBarItem.selectedImage = UIImage(named: "NotificationClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.tabBarItem.image = UIImage(named: "Notification")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mytableview.separatorStyle = .none
        self.mytableview.backgroundView?.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0)
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        header.backgroundColor = UIColor(white: 0, alpha: 0)
        //header.backgroundColor = .red
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: mytableview.frame.width, height: 30))
        footer.backgroundColor = UIColor(white: 0, alpha: 0)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: header.frame.width, height: 100))
        label.textAlignment = NSTextAlignment.center
        label.center = header.center
        label.text = "西屯區"
        label.font.withSize(20)
        label.font = UIFont.boldSystemFont(ofSize: 24)

        header.addSubview(label)
        
        mytableview.tableHeaderView = header
        mytableview.tableFooterView = footer
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
