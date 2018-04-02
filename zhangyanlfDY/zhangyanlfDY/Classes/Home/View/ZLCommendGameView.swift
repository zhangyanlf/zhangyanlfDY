//
//  ZLCommendGameView.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zGameCellID = "zGameCellID"
private let zEdgrInsetMargin : CGFloat = 10

class ZLCommendGameView: UIView {
    
    //MARK: - 定义数据的属性
    var groups : [ZLAnchorGroup]? {
        didSet {
            //1.删除前两个数据
            groups?.removeFirst()
            groups?.removeFirst()
            //2.添加更多数据
            let moreGroup = ZLAnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //3.加载游戏数据
            gameCollectionView.reloadData()
        }
    }
    
    
    ///MARK: - 控件属性
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        
        gameCollectionView.register(UINib(nibName: "ZLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: zGameCellID)
        
        //添加内边距
        gameCollectionView.contentInset = UIEdgeInsets(top: 0, left: zEdgrInsetMargin, bottom: 0, right: zEdgrInsetMargin)
    }

}

//MARK: - 提供快速创建的类方法
extension ZLCommendGameView {
    
    class func zlcommendGameView() -> ZLCommendGameView {
        
        return Bundle.main.loadNibNamed("ZLCommendGameView", owner: nil, options: nil)!.first as! ZLCommendGameView
    }
}

//MARK: - 遵守UICollectionViewDataSource方法
extension ZLCommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: zGameCellID, for: indexPath) as! ZLCollectionGameCell
        cell.group = groups![indexPath.item]
        
        return cell
        
    }
}




