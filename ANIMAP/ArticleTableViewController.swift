//
//  ArticleTableViewController.swift
//  ANIMAP
//
//  Created by 謝忠穎 on 2017/7/7.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headertitle: UILabel!
    @IBOutlet weak var headerbody: UILabel!
    
    let a = [
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean comm. In enimmus ele"
        
        , "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodfelis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus ele"
        
        ,"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus ele"
        
        ,"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commollam ds ele"]
    
    var id: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundView?.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0)
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        headertitle.backgroundColor = UIColor(white: 0, alpha: 0)
        headerbody.backgroundColor = UIColor(white: 0, alpha: 0)

        
        
        headertitle.text = id
        headerbody.text = "來自日本的字體，但也支援繁體漢字與英文字型，部分字體可能會有缺字，但字體相當可愛～S2G Sea font字體下載、S2G Moon font字體下載、S2G Love font字體下載、S2G naguri font字體下載、S2G Uni font字體下載。黑體繁字型下載"
        
        let size = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return a.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custCell", for: indexPath) as! ArticleViewTableViewCell
         cell.bodylabel.text = a[indexPath.row]
         //cell.textLabel?.text = a[indexPath.row]
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
