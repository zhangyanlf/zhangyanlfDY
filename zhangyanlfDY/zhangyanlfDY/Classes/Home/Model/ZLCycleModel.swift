//
//  ZLCycleModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLCycleModel: NSObject {

    /// 标题
    @objc var title : String = ""
    
    /// 图片地址
    @objc var pic_url: String = ""
    
    //主播房间信息对应的字典
    @objc var room: [String : NSObject]? {
        didSet {
           guard let room = room else { return }
            anchor = ZLAnchorModel(dict: room)
            
        }
    }
    
    /// 主播信息对应的模型
    @objc var anchor : ZLAnchorModel?
    
    ///MARK: - 自定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
}
