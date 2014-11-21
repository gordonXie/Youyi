//
//  PurposeItemView.swift
//  Youyi
//
//  Created by xieguocheng on 14-11-21.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

import UIKit

@objc protocol PPItemViewDelegate:NSObjectProtocol{
    
    optional func onNewBtnClick()
    optional func onActionBtnClick()
    optional func onRecordBtnClick()
    optional func onShareBtnClick()
    optional func onMemberBtnClick(index:NSInteger)
}
class PurposeItemView: UIView {
    
    var isNewItem:Bool = false
    var purpose:JPurpose?
    var itemDelegate:PPItemViewDelegate?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.backgroundColor = UIColor.whiteColor()
        if isNewItem {
            self .addSubview(self.createNewButton())
        }else{
            self.createPPView()
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
    
    func createPPView(){
        var actionBtn = UIButton()
        let btnSize:CGFloat = 80.0
        let selfFrame = self.frame
        var frame = CGRectMake((selfFrame.size.width-btnSize)/2.0,(selfFrame.size.height-btnSize)/2.0-20,btnSize,btnSize)
        actionBtn.frame = frame
        actionBtn.setImage(UIImage (named:"addNew"), forState: UIControlState.Normal)
        actionBtn.addTarget(self, action: "onActionBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(actionBtn)
        
        var recordBtn = UIButton()
        let recordBtnEdge:CGFloat = 20.0
        let recordBtnSize:CGFloat = 40.0
        var recordFrame = CGRectMake(recordBtnEdge,selfFrame.size.height-recordBtnEdge-recordBtnSize,recordBtnSize,recordBtnSize)
        recordBtn.frame = recordFrame
        recordBtn.setImage(UIImage (named:"record"), forState: UIControlState.Normal)
        recordBtn.addTarget(self, action: "onrecordBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(recordBtn)
        
        var shareBtn = UIButton()
        var shareFrame = CGRectMake(selfFrame.size.width-recordBtnSize-recordBtnEdge,selfFrame.size.height-recordBtnEdge-recordBtnSize,recordBtnSize,recordBtnSize)
        shareBtn.frame = shareFrame
        shareBtn.setImage(UIImage (named:"share"), forState: UIControlState.Normal)
        shareBtn.addTarget(self, action: "onShareBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(shareBtn)
        
    }
    
    func onActionBtnClick(){
        itemDelegate?.onActionBtnClick?()
    }
    func onRecordBtnClick(){
        itemDelegate?.onRecordBtnClick?()
    }
    func onShareBtnClick(){
        itemDelegate?.onShareBtnClick?()
    }
}
