//
//  UserCenterViewController.swift
//  Youyi
//
//  Created by xieguocheng on 14-11-26.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

import Foundation
import UIKit

class UserCenterVC: JBaseViewController,UITableViewDataSource,UITableViewDelegate{
    var ppArray:NSMutableArray? = ["",""]
    let tableCellHeight:CGFloat = 40.0
    override func initViews() {
        super.initViews()
        self.setTitle("个人中心")
        addBackBtn()
        addRightBtn("设置")
        
        self.addUserInfo()
    }
    
    func addUserInfo(){
        var tableView = UITableView (frame: CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT), style: UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    //UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section==0{
            return 1
        }
        else{
            if ppArray==nil {
                return 0
            }else{
                return ppArray!.count
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier:String = "identify"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell==nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        if indexPath.section==0{
            cell?.imageView.image=UIImage(named: "share")
            cell?.textLabel.text = "我的昵称"
        }else{
            cell?.imageView.image=UIImage(named: "share")
            cell?.textLabel.text = "意向名称"
        }
        
        return cell!
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2;
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section==0{
            return ""
        }else{
            return "我的意向"
        }
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section==0{
            return 60.0;
        }else{
            return tableCellHeight
        }
    }
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//    {
//        
//    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
}
