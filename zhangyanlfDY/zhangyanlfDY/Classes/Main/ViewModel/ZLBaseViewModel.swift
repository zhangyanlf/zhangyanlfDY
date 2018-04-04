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
    func loadAnchorData(urlString: String, paramters: [String : Any]? = nil,finishedCallback: @escaping ()->())
    {
        ZLNetWorkTools.requestDate(type: .GET, urlString: urlString, paramters: paramters) { (result) in
            //1.处理结果
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //2.遍历数组字典
            for dict in dataArray {
                self.anchorGroups.append(ZLAnchorGroup(dict: dict))
            }
            
            //3.回调
            finishedCallback()
        }
    }
}
