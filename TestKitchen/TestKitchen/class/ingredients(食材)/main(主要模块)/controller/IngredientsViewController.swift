//
//  IngredientsViewController.swift
//  TestKitchen
//
//  Created by Silence on 16/10/21.
//  Copyright © 2016年 Silence. All rights reserved.
//

import UIKit



class IngredientsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.cyanColor()
        
        automaticallyAdjustsScrollViewInsets=false
        
        downLoadRecommendData()
    }
    
    //下载首页-推荐数据
    func downLoadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params=["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        
        let downloader=KTCDownloader()
        downloader.delegate=self
        downloader.postWithUrl(kHostUrl, params: params)
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

//MARK:KTCDownloader
extension IngredientsViewController:KTCDownloaderDelegate{
    //下载失败 调用方法
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    //下载成功 调用方法
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
//        let str=NSString(data: data!, encoding: NSUTF8StringEncoding)
        if let tmpData = data{
            //1 json解析
            let recommonModel=IngreRecommend.parseData(tmpData)
            
            //2 显示UI
            let recommendView=IngreRecommendView(frame: CGRectZero)
            recommendView.model=recommonModel
            view.addSubview(recommendView)
            
            //约束
            recommendView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
            
        }
        
    }
}

