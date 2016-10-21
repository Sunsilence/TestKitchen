//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by Silence on 16/10/21.
//  Copyright © 2016年 Silence. All rights reserved.
//

import UIKit


class MainTabBarViewController: UITabBarController {
    
    private var bgView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewControllers()
        
        //隐藏系统tabBar
        tabBar.hidden=true
        createMtTabBar()
        
    }
    
    
    
    
    //自定制tabBar
    func createMtTabBar(){
        //tabBar的背景
        bgView = UIView.createView()
        bgView?.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        //设置边框
//        bgView?.layer.borderColor = UIColor.blackColor().CGColor
//        bgView?.layer.borderWidth=1
        
        
        view.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: {[weak self] (make) in
            make.left.right.bottom.equalTo((self?.view)!)
            make.height.equalTo(49)
        })
        
        //图片名字
        let imagenames=["home","community","shop","shike","mine"]
        //标题文字
        let titles=["食材","社区","商城","食课","我的"]
        
        //循环创建按钮
        let width = kScreenW/CGFloat(imagenames.count)
        for i in 0..<imagenames.count{
            let imageName = imagenames[i]+"_normal"
            let selectName = imagenames[i]+"_select"
            let btn = UIButton.createBtn(nil, bgImageName: imageName, hightLightImageName: nil, selectImageName: selectName, target: self, action: #selector(clickBtn(_:)))
            btn.tag=300+i
            bgView?.addSubview(btn)
            
            //按钮位置设置
            btn.snp_makeConstraints(closure: {[weak self] (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
            })
            //标题设置
            let titleLabel = UILabel.createLabel(titles[i], textAlignment: .Center, font: UIFont.systemFontOfSize(12))
            btn.addSubview(titleLabel)
            //标题位置设置
            titleLabel.snp_makeConstraints(closure: {(make) in
                make.left.bottom.right.equalTo(btn)
                make.height.equalTo(15)
            })
            
        }
    }
    
    func clickBtn(curBtn:UIButton){
        let index = curBtn.tag-300
        //1.1 选中当前的按钮
        if selectedIndex != index{
            
        }
        let lastBtn=bgView?.viewWithTag(300+selectedIndex) as! UIButton
        lastBtn.selected = false
        lastBtn.userInteractionEnabled = true
        //1.2 取消选中之前的按钮
        curBtn.selected=true
        curBtn.userInteractionEnabled = false
        selectedIndex = index
        
        //1.3 切换视图控制器
    }
    
    
    //创建视图控制器
    func createViewControllers(){
        //视图控制器的名字
        let nameArray=["TestKitchen.CommunityViewController","TestKitchen.FoodClassViewController","TestKitchen.IngredientsViewController","TestKitchen.MallViewController","TestKitchen.ProfileViewController"]
        
        //视图控制器对象的数组
        var ctrlArray:[UINavigationController]=[]
        for i in 0..<nameArray.count{
            let name=nameArray[i]
            //使用类名创建类的对象
            let ctrl = NSClassFromString(name) as! UIViewController.Type
            
            let vc = ctrl.init()
            //导航
            let navCtrl = UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)
            
        }
        viewControllers = ctrlArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
