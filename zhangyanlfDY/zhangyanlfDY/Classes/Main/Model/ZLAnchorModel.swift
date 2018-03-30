//
//  ZLAnchorModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLAnchorModel: NSObject {

    /// 直播地址
   @objc var jumpUrl: NSString!
    
    /// 房间ID
   @objc var room_id: Int = 0
    /// 房间图片对应url
   @objc var vertical_src: String = ""
    /// 判断直播的设备类型 0:电脑   1:手机
   @objc var isVertical: Int = 0
    /// 房间名称
   @objc var room_name: String = ""
    /// 主播名称
   @objc var nickname: String = ""
    /// 在线人数
   @objc var online: Int = 0
    
    /// 所在城市
   @objc var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    
    
}
