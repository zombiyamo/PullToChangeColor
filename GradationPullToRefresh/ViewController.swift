//
//  ViewController.swift
//  GradationPullToRefresh
//
//  Created by miyamo on 2015/10/31.
//  Copyright © 2015年 miyamoto haruna. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tblDemo: UITableView!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    
    var dataArray: Array<String> = ["A","B","C","D"]
    var refreshControll: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tblDemo = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tblDemo.registerClass(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        
        tblDemo.delegate = self
        tblDemo.dataSource = self
        
        refreshControll = UIRefreshControl()
        refreshControll.backgroundColor = UIColor.greenColor()
        refreshControll.tintColor = UIColor.whiteColor()
        
        tblDemo.addSubview(refreshControll)
        self.view.addSubview(tblDemo)
        
        loadCustomRefreshContents()
    }
    
    func loadCustomRefreshContents(){
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        customView = refreshContents[0] as! UIView
        customView.frame = refreshControll.bounds
        refreshControll.addSubview(customView)
    }
    
    func pullToRefreshGradationColor(){
        
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath:  indexPath) as UITableViewCell
        
        cell.textLabel!.text = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

