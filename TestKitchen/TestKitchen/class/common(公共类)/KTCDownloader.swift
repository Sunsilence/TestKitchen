//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by Silence on 16/10/24.
//  Copyright © 2016年 Silence. All rights reserved.
//

import UIKit
import Alamofire

protocol KTCDownloaderDelegate:NSObjectProtocol {
    //下载失败
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    
    //下载成功
    func downloader(downloader:KTCDownloader,didFinishWithData data:NSData?)
    
}


class KTCDownloader: NSObject {
    //代理属性
    weak var delegate:KTCDownloaderDelegate?
    
    
    //POST请求
    func postWithUrl(urlString:String,params:[String:AnyObject]){
        
        Alamofire.request(.POST, urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData { (responce) in
            switch responce.result{
            case .Failure(let error):
                //下载失败
                self.delegate?.downloader(self, didFailWithError: error)
                
            case .Success:
                //下载成功
                self.delegate?.downloader(self, didFinishWithData: responce.data)
            }
        }
    }
    
    
}
