//
//  ZLCollectionGameCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Kingfisher

class ZLCollectionGameCell: UICollectionViewCell {

    //MARK: - 定义模型属性
    var group : ZLAnchorGroup? {
        didSet {
            gamaTitleLabel.text = group?.tag_name
            let gameURL = URL(string: group?.icon_url ?? "")
            gamaImageView.kf.setImage(with: gameURL, placeholder: #imageLiteral(resourceName: "home_more_btn"))
            
        }
    }
    
    var gameModel : ZLGameModel? {
        didSet {
            gamaTitleLabel.text = gameModel?.game_name
            let gameURL = URL(string: gameModel?.game_icon ?? "")
            gamaImageView.kf.setImage(with: gameURL, placeholder: #imageLiteral(resourceName: "home_more_btn"))
        }
    }
    
    //MARK: - 控件属性
    /// 游戏图片
    @IBOutlet weak var gamaImageView: UIImageView!
    
    /// 游戏文字
    @IBOutlet weak var gamaTitleLabel: UILabel!
    
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
