//
//  UIButton+Common.swift
//  TestKitchen1
//
//  Created by Silence on 16/10/21.
//  Copyright © 2016年 Silence. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    class func createBtn(title:String?,bgImageName:String?, hightLightImageName:String?,selectImageName:String?,target:AnyObject?,action:Selector)->UIButton{
        let btn = UIButton(type: .Custom)
        if let tmpTitle=title{
            btn.setTitle(tmpTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let tmpBgImageName=bgImageName{
            btn.setBackgroundImage(UIImage(named: tmpBgImageName), forState: .Normal)
        }
        if let tmpHightLightName=hightLightImageName{
            btn.setBackgroundImage(UIImage(named: tmpHightLightName), forState: .Highlighted)
        }
        if let tmpSelectName=selectImageName{
            btn.setBackgroundImage(UIImage(named: tmpSelectName), forState: .Selected)
        }
        if target != nil && action != nil{
            btn .addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        return btn
    }
}
