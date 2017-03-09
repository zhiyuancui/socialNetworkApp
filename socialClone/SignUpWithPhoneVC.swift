//
//  SignUpWithPhone.swift
//  socialClone
//
//  Created by Zhiyuan Cui on 3/9/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SignUpWithPhoneVC: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo{
        return IndicatorInfo(title:"Phone")
    }
    

}
