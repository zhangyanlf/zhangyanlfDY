//
//  ZLCollectionHeaderView.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLCollectionHeaderView: UICollectionReusableView {

    //MARK: - 控件属性
    /// 标题名称
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 标题图片
    @IBOutlet weak var iconImage: UIImageView!
    
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    //定义模型属性
    var group : ZLAnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImage.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

//MARK: - 从Xib中快速创建的类方法
extension ZLCollectionHeaderView {
    class func colectionHeaderView () -> ZLCollectionHeaderView {
        return Bundle.main.loadNibNamed("ZLCollectionHeaderView", owner: nil, options: nil)?.first as! ZLCollectionHeaderView
    }
}



