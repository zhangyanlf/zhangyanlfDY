//
//  ZLCollectionPrettyCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Kingfisher

class ZLCollectionPrettyCell: ZLCollectionBaseCell {
    //MARK: - 控件属性

    /// 所在城市
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK: - 定义模型属性
   override var anchor : ZLAnchorModel? {
        didSet {
            //1.属性传递给父类
            super.anchor = anchor
            //3.所在城市显示
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        
        }
    }
    

}
