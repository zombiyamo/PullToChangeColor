//
//  PullToChangeColor.swift
//  PullToChangeColor
//
//  Created by miyamo on 2015/10/31.
//  Copyright © 2015年 miyamoto haruna. All rights reserved.
//

import UIKit

class PullToChangeColor: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tblDemo: UITableView!
    var customView: UIView!
    var refreshImageView: UIImageView!
    
    var dataArray: Array<String> = ["A","B","C","D"]
    var refreshControl: UIRefreshControl!
    
    var isAnimating = false
    var timer: NSTimer!
    var gradationTimer: NSTimer!
    var cnt: Int = 0
    var colorcnt: Int!
    var changeColorInterval: Double  = 0.5
    var endOfWorkInterval: Double  = 2.0
    var currentColorIndex = 0
    
    var currentLabelIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tblDemo = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tblDemo.registerClass(UITableViewCell.self, forCellReuseIdentifier: "idCell")
        
        tblDemo.delegate = self
        tblDemo.dataSource = self
        refreshControl = UIRefreshControl()
        tblDemo.addSubview(refreshControl)
        
        self.view.addSubview(tblDemo)
        loadCustomRefreshContents()
        colorOptions()
    }
    
    func colorOptions(){
        
        
        refreshControl.backgroundColor = getColor()
        refreshControl.tintColor = UIColor.clearColor()
        customView.backgroundColor = getColor()
        customView.tintColor = UIColor.clearColor()
        changeColorInterval = 0.5
        endOfWorkInterval = 2.0
        
    }
    
    func getColor() -> UIColor {
        let customColorArray = [UIColor.redColor(),UIColor.cyanColor(),UIColor.orangeColor(),UIColor.greenColor(),UIColor.purpleColor(),UIColor.blueColor()]
        colorcnt = customColorArray.count - 1
        if cnt < colorcnt {
            cnt += 1
        }else {
            cnt = 0
        }
        
        return customColorArray[cnt]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if refreshControl.refreshing{
            refreshControlTimer()
        }
    }

    func loadCustomRefreshContents() {
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        customView = refreshContents[0] as! UIView
        customView.frame = refreshControl.bounds
        refreshControl.addSubview(customView)
    }
    
    
    
    func refreshControlTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(endOfWorkInterval, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
        gradationTimer = NSTimer.scheduledTimerWithTimeInterval(changeColorInterval, target: self, selector: "gradation", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        
        refreshControl.endRefreshing()
        if timer.valid {
        timer.invalidate()
        gradationTimer.invalidate()
        }
    }
    
    func gradation() {
        
        UIView.animateWithDuration(
            changeColorInterval,
            animations:{ () -> Void in
                self.customView.backgroundColor = self.getColor()
            }
        
        )

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

