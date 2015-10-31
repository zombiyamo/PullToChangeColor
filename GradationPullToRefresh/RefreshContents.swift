//
//  RefreshContents.swift
//  PullToChangeColor
//
//  Created by miyamo on 2015/10/31.
//  Copyright © 2015年 miyamoto haruna. All rights reserved.
//

import Foundation
import UIKit

class RefreshContents: UIView {
    @IBOutlet weak var refreshImageView: UIImageView!
    
    class func instance() -> RefreshContents {
        return UINib(nibName: "RefreshContents", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! RefreshContents
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.refreshImageView.transform = CGAffineTransformMakeRotation(0)
        
    }

    
    
}