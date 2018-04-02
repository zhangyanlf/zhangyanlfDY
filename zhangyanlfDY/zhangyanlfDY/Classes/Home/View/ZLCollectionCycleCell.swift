//
//  ZLCollectionCycleCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Kingfisher

class ZLCollectionCycleCell: UICollectionViewCell {
    
    /// 轮播图片
    @IBOutlet weak var cycleImageView: UIImageView!
    
    /// 轮播标题
    @IBOutlet weak var cycleTitleLabel: UILabel!
    
    var cycleModel : ZLCycleModel? {
        didSet {
            //0.检验模型是否有值
            guard let cycleModel = cycleModel else { return }
            //1.显示标题
            cycleTitleLabel.text = cycleModel.title
            //2.显示图片
            guard let url = URL(string: cycleModel.pic_url) else {
                return
            }
            
            cycleImageView.kf.setImage(with: url)
            
        }
    }
    

}
