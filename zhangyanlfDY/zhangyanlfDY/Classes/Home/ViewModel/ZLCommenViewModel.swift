//
//  ZLCommenViewModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Foundation

class ZLCommenViewModel {
    //MARK: - 懒加载数组
    lazy var anchorGroups: [ZLAnchorGroup] = [ZLAnchorGroup]()
    lazy var cycleModels: [ZLCycleModel] = [ZLCycleModel]()
    private lazy var bigDataGroup: ZLAnchorGroup = ZLAnchorGroup()
    private lazy var prettyGroup: ZLAnchorGroup = ZLAnchorGroup()
    
}

//MARK: - 发送网络请求
extension ZLCommenViewModel {
    ///请求推荐数据
    func requestData(finishCallBack:@escaping () -> ()) {
        //1.自定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time": Date.getCurrentTime()]
        //2.创建Gruoup
        let disGroup = DispatchGroup()
        disGroup.enter()
        //3.请求第一组推荐数据
        ZLNetWorkTools.requestDate(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramters: ["time": Date.getCurrentTime()]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典 转成模型对象
            //3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchor = ZLAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.4离开组
            disGroup.leave()
        }
        
        
        //4.请求颜值数据
        // 1).定义参数
        disGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1522371234
        ZLNetWorkTools.requestDate(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramters: parameters) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典 转成模型对象
            //3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_normal"
            for dict in dataArray {
                let anchor = ZLAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.4离开组
            disGroup.leave()
        }
        
        
        //5.2-12 请求后面的部分数据
        disGroup.enter()
        print(Date.getCurrentTime())
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1522371234
        // 1).定义参数
        
        ZLNetWorkTools.requestDate(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", paramters: parameters) { (result) in
            
           
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.遍历数组 获取字典 并且将字典转为模型对象
            for dict in dataArray {
                let group = ZLAnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //4.离开组
            disGroup.leave()
        }
        
        //6.所有的数据都请求到 之后进行排序
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
        
        
    }
 
    /// 请求轮播数据
    func requestCycleDat(finishCallBack: @escaping () -> ()) {
        ZLNetWorkTools.requestDate(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", paramters: ["version" : "2.300"]) { (result) in
            //1.获取整体数据
            guard let resultDic = result as? [String : NSObject] else { return }
            //2.根据data的key获取数据
            guard let resultArray = resultDic["data"] as? [[String : NSObject]] else { return }
            //3.遍历字典转模型
            for dict in resultArray {
                self.cycleModels.append(ZLCycleModel(dict: dict))
            }
            
            finishCallBack()
        }
    }


    
    
}
