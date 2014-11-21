//
//  PurposeItemView.swift
//  Youyi
//
//  Created by xieguocheng on 14-11-21.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

import UIKit

@objc protocol PPItemViewDelegate:NSObjectProtocol{
    
    optional func  onNewBtnClick()
    
}
class PurposeItemView: UIView {
    
    var isNewItem:Bool = false
    var itemDelegate:PPItemViewDelegate?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.backgroundColor = UIColor.whiteColor()
        if isNewItem {
            self .addSubview(self.createNewButton())
        }
    }

    func createNewButton()->UIButton{
        var newBtn = UIButton()
        let btnSize:CGFloat = 80.0
        let selfFrame = self.frame
        var frame = CGRectMake((selfFrame.size.width-btnSize)/2.0,(selfFrame.size.height-btnSize)/2.0-20,btnSize,btnSize)
        newBtn.frame = frame
        newBtn.setImage(UIImage (named:"addNew"), forState: UIControlState.Normal)
        newBtn.addTarget(self, action: "onNewBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return newBtn
    }

    func onNewBtnClick(){
        itemDelegate?.onNewBtnClick?()
    }
}
