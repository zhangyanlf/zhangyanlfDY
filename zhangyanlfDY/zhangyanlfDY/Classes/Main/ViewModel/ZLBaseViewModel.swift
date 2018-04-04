//
//  ZLBaseViewModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLBaseViewModel {
    lazy var anchorGroups : [ZLAnchorGroup] = [ZLAnchorGroup]()
}

extension ZLBaseViewModel {
    func loadAnchorData(isGroupData: Bool, urlString: String, paramters: [String : Any]? = nil,finishedCallback: @escaping ()->())
    {
        ZLNetWorkTools.requestDate(type: .GET, urlString: urlString, paramters: paramters) { (result) in
            //1.处理结果
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //2.判断是否是分组数据
            if isGroupData { //是分组数据
                //2.1遍历数组字典
                for dict in dataArray {
                    self.anchorGroups.append(ZLAnchorGroup(dict: dict))
                }
            } else {
                //2.2创建一个组
                let groups = ZLAnchorGroup()
                //2.3遍历dataArray的所有字典
                for dict in dataArray{
                    groups.anchors.append(ZLAnchorModel(dict: dict))
                }
                //2.4 将创建的groups添加到ZLAnchorGroup
                self.anchorGroups.append(groups)
                
            }
            //3.回调
            finishedCallback()
        }
    }
}
