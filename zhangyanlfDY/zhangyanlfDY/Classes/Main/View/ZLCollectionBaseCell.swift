//
//  ZLCollectionBaseCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/30.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLCollectionBaseCell: UICollectionViewCell {
    //MARK: - 控件属性
    
    /// 主播图片显示
    @IBOutlet weak var iconImageView: UIImageView!
    
    /// 主播名称
    @IBOutlet weak var nickNameLabel: UILabel!
    /// 在线人数
    @IBOutlet weak var onLineNumber: UIButton!
    
    //MARK: - 定义模型属性
    var anchor : ZLAnchorModel? {
        didSet {
            //0.检验模型是否有值
            guard let anchor = anchor else { return }
            //1.取出在线人数显示的文字
            var onLineStr: String = ""
            if anchor.online >= 10000 {
                onLineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onLineStr = "\(Int(anchor.online))人在线"
            }
            onLineNumber.setTitle(onLineStr, for: .normal)
            
            //2.昵称显示
            nickNameLabel.text = anchor.nickname
            
            //4.显示封面图片
            guard let iconUrl = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
