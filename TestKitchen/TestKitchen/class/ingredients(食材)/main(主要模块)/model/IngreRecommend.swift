//
//  IngreRecommend.swift
//  TestKitchen
//
//  Created by Silence on 16/10/24.
//  Copyright © 2016年 Silence. All rights reserved.
//

import UIKit

import SwiftyJSON

class IngreRecommend: NSObject {
    var code:NSNumber?
    var data:IngreRecommendData?
    var msg:NSNumber?
    var timestamp:NSNumber?
    var version:String?
    
    //解析
    class func parseData(data:NSData)->IngreRecommend{
        
        let json=JSON(data:data)
        
        let model=IngreRecommend()
        model.code=json["code"].number
        model.data=IngreRecommendData.parseModel(json["data"])
        model.msg=json["msg"].number
        model.timestamp=json["timestamp"].number
        model.version=json["version"].string
        
        return model
    }
    
}

class IngreRecommendData:NSObject{
    var bannerArray:[IngreRecommendBanner]?
    var widgetList:[IngreRecommendWidgetList]?
    
    //解析
    class func parseModel(json:JSON)->IngreRecommendData{
        let model = IngreRecommendData()
        
        var tmpBannerArray=[IngreRecommendBanner]()
        for (_,subjson) in json["banner"]{
            tmpBannerArray.append(IngreRecommendBanner.parseModel(subjson))
        }
        model.bannerArray=tmpBannerArray
        
        //列表数据
        var tmpList = [IngreRecommendWidgetList]()
        for (_,subjson):(String,JSON) in json["widgetList"]{
            tmpList.append(IngreRecommendWidgetList.parseModel(subjson))
        }
        model.widgetList=tmpList

        return model
    }
}

class IngreRecommendBanner:NSObject{
    var banner_id:NSNumber?
    var banner_link:String?
    var banner_picture:String?
    var banner_title:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    var type_id:NSNumber?
    
    //解析
    class func parseModel(json:JSON)->IngreRecommendBanner{
        let modle=IngreRecommendBanner()
        modle.banner_id=json["banner_id"].number
        modle.banner_link=json["banner_link"].string
        modle.banner_picture=json["banner_picture"].string
        modle.banner_title=json["banner_title"].string
        modle.is_link=json["is_link"].number
        modle.refer_key=json["refer_key"].number
        modle.type_id=json["type_id"].number
        
        return modle
    }
}

class IngreRecommendWidgetList:NSObject{
    var desc:NSNumber?
    var title:String?
    var title_link:NSNumber?
    var widget_data:[IngreRecommendWidgetData]?
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    
    //解析
    class func parseModel(json:JSON)->IngreRecommendWidgetList{
        let model=IngreRecommendWidgetList()
        model.desc=json["desc"].number
        model.title=json["title"].string
        model.title_link=json["title_link"].number
        
        var dataArray=[IngreRecommendWidgetData]()
        for (_,subjson):(String,JSON) in json["widget_data"]{
            dataArray.append(IngreRecommendWidgetData.parseModel(subjson))
        }
        model.widget_data=dataArray
        
//        model.widget_data=IngreRecommendWidgetData.parseModel(json["widget_data"])
        model.widget_id=json["widget_id"].number
        model.widget_type=json["widget_type"].number
        
        return model
    }
}


class IngreRecommendWidgetData:NSObject{
    var content:String?
    var id:NSNumber?
    var link:String?
    var type:String?
    
    class func parseModel(json:JSON)->IngreRecommendWidgetData{
        let model=IngreRecommendWidgetData()
        model.content=json["content"].string
        model.id=json["id"].number
        model.link=json["link"].string
        model.type=json["type"].string
        
        return model
    }
}






