//
//  ZLCollectionNormalCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLCollectionNormalCell: ZLCollectionBaseCell {

    
    //MARK: - 控件属性
    /// 房间名称
    @IBOutlet weak var roomNameLabel: UILabel!
    //MARK: - 定义模型属性
    override var anchor : ZLAnchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            //3.房间名称
            roomNameLabel.text = anchor?.room_name
            
            
        }
    }
    
    
}
