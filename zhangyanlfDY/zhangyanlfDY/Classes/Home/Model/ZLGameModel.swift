//
//  ZLGameModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLGameModel: NSObject {

    //MARK: - 定义属性
    @objc var game_name: String = ""
    
    @objc var game_icon: String = ""
    
    
    //MARK: - 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
