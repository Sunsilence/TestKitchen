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
        
        
        
    }
    
    
    
    
    //自定制tabBar
    func createMtTabBar(imagenames:[String],titles:[String]){
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
            //设置文字颜色
            titleLabel.textColor=UIColor.lightGrayColor()
            titleLabel.tag=400
            btn.addSubview(titleLabel)
            
            //标题位置设置
            titleLabel.snp_makeConstraints(closure: {(make) in
                make.left.bottom.right.equalTo(btn)
                make.height.equalTo(15)
            })
            //默认第一个按钮被选中
            if i==0{
                btn.selected=true
                titleLabel.textColor=UIColor.brownColor()
            }
        }
    }
    
    func clickBtn(curBtn:UIButton){
        let index = curBtn.tag-300
        //1.1 选中当前的按钮
        let lastBtn=bgView?.viewWithTag(300+selectedIndex) as! UIButton
        lastBtn.selected = false
        lastBtn.userInteractionEnabled = true
        let lastLabel=lastBtn.viewWithTag(400) as! UILabel
        lastLabel.textColor=UIColor.lightGrayColor()
        
        //1.2 取消选中之前的按钮
        curBtn.selected=true
        curBtn.userInteractionEnabled = false
        let curLabel=curBtn.viewWithTag(400) as! UILabel
        curLabel.textColor=UIColor.brownColor()
        
        selectedIndex = index
        
        //1.3 切换视图控制器
    }
    
    //2 创建视图控制器
    //创建视图控制器
    func createViewControllers(){
        
        //1.从Controllers.json文件里面读取数据
        let path=NSBundle.mainBundle().pathForResource("Controllers", ofType: "json")
        let data=NSData(contentsOfFile: path!)
        //视图控制器名字的数组
        var nameArray=[String]()
        //图片名字
        var images=[String]()
        
        //标题名字
        var titles=[String]()
        
        do {
            //可能抛异常的代码写在这里
            let json=try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if json.isKindOfClass(NSArray){
                let tmpArray = json as! [[String:String]]
                //遍历获取视图控制器的名字
                for tmpDic in tmpArray{
                    let name=tmpDic["ctrlname"]
                    nameArray.append(name!)
                    
                    images.append(tmpDic["image"]!)
                    
                    titles.append(tmpDic["title"]!)
                }
            }
        } catch (let error) {
            //捕获错误信息
            print(error)
        }
        
        //如果获取的数据有错误
        if nameArray.count==0{
            //视图控制器名字
            nameArray=["TestKitchen.CommunityViewController","TestKitchen.FoodClassViewController","TestKitchen.IngredientsViewController","TestKitchen.MallViewController","TestKitchen.ProfileViewController"]
            //图片的名字
            images=["home","community","shop","shike","mine"]
            //标题的文字
            titles=["食材","社区","商城","食课","我的"]
        }
        
        
        //
        //        //视图控制器的名字
        //
        
        //视图控制器对象的数组
        var ctrlArray:[UINavigationController]=[]
        for i in 0..<nameArray.count{
            let name="TestKitchen."+nameArray[i]
            //使用类名创建类的对象
            let ctrl = NSClassFromString(name) as! UIViewController.Type
            
            let vc = ctrl.init()
            //导航
            let navCtrl = UINavigationController(rootViewController: vc)
            ctrlArray.append(navCtrl)
            
        }
        viewControllers = ctrlArray
        
        //3 设置图片和文字
        //隐藏系统tabBar
        tabBar.hidden=true
        createMtTabBar(images,titles: titles)
        
        
        
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
