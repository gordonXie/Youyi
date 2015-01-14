//
//  PurposeRecordViewController.swift
//  Youyi
//
//  Created by xieguocheng on 14-12-12.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

import Foundation
import UIKit

class PurposeRecordViewController: JBaseViewController {
    var chvc:CalendarHomeViewController?;
    override func initViews() {
        super.initViews()
        self.setTitle("记录")
        self.addBackBtn()
        
        self.addCalender()
    }
    
    func addCalender(){
//        chvc = 
    }
}
