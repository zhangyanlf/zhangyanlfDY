//
//  ZLAmusemenuCell.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/4.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zGameMeunCellID = "zGameMeunCellID"

class ZLAmusemenuCell: UICollectionViewCell {

    //MARK: - 数组模型
    var groups : [ZLAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - XIB加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ZLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: zGameMeunCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}

extension ZLAmusemenuCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zGameMeunCellID, for: indexPath) as! ZLCollectionGameCell
        cell.clipsToBounds = true
        //2.给cell社设置数据
        cell.group = groups?[indexPath.item]
        //返回cell
        return cell
        
    }
    
    
}
