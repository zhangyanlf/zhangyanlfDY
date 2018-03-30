//
//  ZLAnchorGroup.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLAnchorGroup: NSObject {

    /// 该组中对应的房间信息
   @objc var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else {return}
            for dict in room_list {
                    anchors.append(ZLAnchorModel(dict: dict))
                }
            }
        }
    ///组显示的标题
    @objc var tag_name: String = ""
    
    /// 组显示的图标
    @objc var icon_name: String = "home_header_normal"
    
    @objc lazy var anchors : [ZLAnchorModel] = [ZLAnchorModel]()
    
    /// MARK: - 构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
