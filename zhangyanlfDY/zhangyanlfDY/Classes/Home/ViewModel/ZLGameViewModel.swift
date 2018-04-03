//
//  ZLGameViewModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLGameViewModel {

     lazy var games : [ZLGameModel] = [ZLGameModel]()
}

extension ZLGameViewModel {
    func loadAllGameData(finishedCallBack: @escaping () -> ()) {
        
        ZLNetWorkTools.requestDate(type: .GET, urlString: "http://open.douyucdn.cn/api/RoomApi/game") { (result) in
            //1.获取数据
            guard let resultDict = result as? [String : Any] else { return }
            //2.获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //3.字典转模型
            for dict in dataArray {
                self.games.append(ZLGameModel(dict: dict as! [String : NSObject]))
            }
            
            //4.回调
            finishedCallBack()
        
        }
    }
}
