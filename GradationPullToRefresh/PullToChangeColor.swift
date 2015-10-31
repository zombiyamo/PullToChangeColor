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
    var labelsArray: Array<UILabel> = []
    
    var dataArray: Array<String> = ["A","B","C","D"]
    var colorArray = [UIColor]()
    var refreshControll: UIRefreshControl!
    
    var isAnimating = false
    var timer: NSTimer!
    var gradationTimer: NSTimer!
    var cnt: Int = 0
    var colorcnt: Int!
    var changeColorInterval: Double  = 0.5
    
    
    
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
        refreshControllOptions()
        tblDemo.addSubview(refreshControll)
        
        self.view.addSubview(tblDemo)
       
    }
    
    func refreshControllOptions(){
        
        //refreshControll.backgroundColor = UIColor.greenColor()
        refreshControll.backgroundColor = getColor()
        refreshControll.tintColor = UIColor.whiteColor()
        
    }
    
    func getColor() -> UIColor {
        colorArray = [UIColor.redColor(),UIColor.orangeColor(),UIColor.greenColor(),UIColor.purpleColor()]
        colorcnt = colorArray.count - 1
        if cnt < colorcnt {
            cnt += 1
        }else {
            cnt = 0
        }
        
        return colorArray[cnt]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControll.refreshing{
            refreshControllTimer()
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if !refreshControll.refreshing {
            refreshControllOptions()
        }
    }
    

    
    
    func refreshControllTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
        gradationTimer = NSTimer.scheduledTimerWithTimeInterval(changeColorInterval, target: self, selector: "gradation", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        
        refreshControll.endRefreshing()
        if timer.valid {
        timer.invalidate()
        gradationTimer.invalidate()
        }
    }
    
    func gradation() {

        UIView.animateWithDuration(
            changeColorInterval,
            animations:{ () -> Void in
                self.refreshControll.backgroundColor = self.getColor()
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

