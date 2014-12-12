//
//  PurposeItemView.swift
//  Youyi
//
//  Created by xieguocheng on 14-11-21.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

import UIKit

let pi:CGFloat = 3.1415926

@objc protocol PPItemViewDelegate:NSObjectProtocol{
    
    optional func onNewBtnClick()
    optional func onActionBtnClick()
    optional func onActionBtnLongPress()
    optional func onRecordBtnClick()
    optional func onShareBtnClick()
    optional func onMemberBtnClick(index:NSInteger)
}
class PurposeItemView: UIView {
    
    var isNewItem:Bool = false
    var purpose:JPurpose?
    var itemDelegate:PPItemViewDelegate?
    var ppItem:JPurpose?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.backgroundColor = UIColor.whiteColor()
        if isNewItem {//新建
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
        //添加动作按钮
        var actionBtn = UIButton()
        let btnSize:CGFloat = 80.0
        let selfFrame = self.frame
        var frame = CGRectMake((selfFrame.size.width-btnSize)/2.0,(selfFrame.size.height-btnSize)/2.0-20,btnSize,btnSize)
        actionBtn.frame = frame
        actionBtn.setImage(UIImage (named:"addNew"), forState: UIControlState.Normal)
        actionBtn.setImage(UIImage (named: "share"), forState: UIControlState.Highlighted)
//        actionBtn.addTarget(self, action: "onActionBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(actionBtn)
        //添加单击手势
        var singleGesture = UITapGestureRecognizer(target: self, action: "onActionBtnClick")
        singleGesture.numberOfTapsRequired=1
        actionBtn.addGestureRecognizer(singleGesture)
        //添加长按手势 用来操作该意向(申请加入，退出或关闭(外人，内人，主人))
        var longPress = UILongPressGestureRecognizer(target: self, action: "onActionBtnLongPress")
        longPress.numberOfTouchesRequired = 1
        actionBtn.addGestureRecognizer(longPress)
        
        //添加成员显示
        self.addItemMembers(actionBtn.center)
        
        //添加记录按钮
        var recordBtn = UIButton()
        let recordBtnEdge:CGFloat = 20.0
        let recordBtnSize:CGFloat = 40.0
        var recordFrame = CGRectMake(recordBtnEdge,selfFrame.size.height-recordBtnEdge-recordBtnSize,recordBtnSize,recordBtnSize)
        recordBtn.frame = recordFrame
        recordBtn.setImage(UIImage (named:"record"), forState: UIControlState.Normal)
        recordBtn.addTarget(self, action: "onRecordBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(recordBtn)
        
        //添加分享按钮
        var shareBtn = UIButton()
        var shareFrame = CGRectMake(selfFrame.size.width-recordBtnSize-recordBtnEdge,selfFrame.size.height-recordBtnEdge-recordBtnSize,recordBtnSize,recordBtnSize)
        shareBtn.frame = shareFrame
        shareBtn.setImage(UIImage (named:"share"), forState: UIControlState.Normal)
        shareBtn.addTarget(self, action: "onShareBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(shareBtn)
        
    }
    
    //添加意向成员，设计为圆形显示
    func addItemMembers(centerPoint:CGPoint){

        let membBtnSize:CGFloat = 50.0   //60.0
        let edgeSize:CGFloat = 10.0  //边距
        let selfFrameSize = self.frame.size
        let radius:CGFloat = (selfFrameSize.width-(edgeSize*2+membBtnSize))/2.0     //半径
        var angle:CGFloat = 360.0     //角度间隔
        let membCount = ppItem?.memberArray.count
        if(membCount>0){
            angle = angle/CGFloat(membCount!)
        }
        println("centerX is \(centerPoint.x),centerY is \(centerPoint.y)")
        println("radius is \(radius)")
        var startAngle:CGFloat = 180.0     //开始角度 180.0,是第一个成员（创建者）在左水平位置
        for (var i=0;i<membCount;i++) {
            /*圆点坐标：(x0,y0)
            半径：r
            角度：a0
            则圆上任一点为：（x1,y1）
            x1   =   x0   +   r   *   cos(ao   *   3.14   /180   )
            y1   =   y0   +   r   *   sin(ao   *   3.14   /180   )
            */
            let membCenterP:CGPoint = CGPoint(x:radius*cos(startAngle*pi/180)+centerPoint.x,y:radius*sin(startAngle*pi/180)+centerPoint.y)
            var membBtn:UIButton = UIButton(frame: CGRect(origin: CGPoint(x: membCenterP.x-membBtnSize/2.0, y: membCenterP.y-membBtnSize/2.0), size: CGSize(width: membBtnSize, height: membBtnSize)))
//            membBtn.setImage(UIImage (named:"share"), forState: UIControlState.Normal)
            membBtn.setBackgroundImage(UIImage (named: "share"), forState: UIControlState.Normal)
            membBtn.setTitle("\(i)", forState: UIControlState.Normal)
            membBtn.tag = MEMBERBTN_BASETAG+i;
            membBtn.addTarget(self, action: "onMemberBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(membBtn)
            
            println("startAngle is \(startAngle)")
            println("membCenterP is \(membCenterP)")
            println("membBtn frame is \(membBtn.frame)")
            
            startAngle += angle;
        }
        
    }
    
    func onActionBtnClick(){
        itemDelegate?.onActionBtnClick?()
    }
    func onActionBtnLongPress(){
        itemDelegate?.onActionBtnLongPress?()
    }
    func onRecordBtnClick(){
        itemDelegate?.onRecordBtnClick?()
    }
    func onShareBtnClick(){
        itemDelegate?.onShareBtnClick?()
    }
    func onMemberBtnClick(index:NSInteger){
        itemDelegate?.onMemberBtnClick?(index)
    }
    
}
