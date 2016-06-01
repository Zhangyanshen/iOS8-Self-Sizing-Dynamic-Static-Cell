//
//  CViewController.swift
//  手写约束玩玩
//
//  Created by 张延深 on 16/5/31.
//  Copyright © 2016年 宜信. All rights reserved.
//

import UIKit

class CViewController: UITableViewController {

    @IBOutlet weak var testLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLbl.text = "我可以永远笑着扮演你的配角，在你的背后自己煎熬，如果你不想要想退出要趁早，我没有非要一起到老，我可以不问感觉继续为爱讨好，冷眼的看着你的骄傲，若有情太难了想别恋要趁早，就算迷恋你的拥抱，忘了就好"
        
        // 静态cell中这两句话是不管用的，要用delegate实现
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 44.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.contentSizeCategoryDidChange(_:)), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    // MARK: - event response
    
    func contentSizeCategoryDidChange(notification: NSNotificationCenter) {
        
        self.updateFont()
    }
    
    @IBAction func addText(sender: UIBarButtonItem) {
        
        testLbl.text?.appendContentsOf("+这是新加的String+")
        tableView.reloadData()
    }
    
    @IBAction func reduceText(sender: UIBarButtonItem) {
        
        if testLbl.text?.characters.count > 5 {
            let index = testLbl.text?.endIndex.advancedBy(-5)
            testLbl.text = testLbl.text?.substringToIndex(index!)
            tableView.reloadData()
        }
    }
    
    // MARK: - private methods
    
    private func updateFont() {
        
        testLbl.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    // MARK: - deinit
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

}
