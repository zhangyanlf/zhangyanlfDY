//
//  ZLRecommendCycleView.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/30.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Foundation

private let zCycleCellID = "zCycleCellID"

class ZLRecommendCycleView: UIView {
    
    ///MARK: -  定义属性
    var cycleModels : [ZLCycleModel]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = (cycleModels?.count)!
        }
    }
    
    
    //MARK: - 控件属性
    ///collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// pageControl
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册Cell
        
        collectionView.register(UINib(nibName: "ZLCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: zCycleCellID)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
    }

}

//MARK: - 提供一个创建View的类方法
extension ZLRecommendCycleView {
    class func recommendCycleView() -> ZLRecommendCycleView {
        
        return Bundle.main.loadNibNamed("ZLRecommendCycleView", owner: nil, options: nil)!.first as! ZLRecommendCycleView
    }
}

//MARK: - 遵守UICollectionViewDataSource代理
extension ZLRecommendCycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zCycleCellID, for: indexPath) as! ZLCollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
       
        return cell
        
    }
}
//MARK: - 遵守UICollectionViewDataSource代理
extension ZLRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //2.计算pageCotroller 的 currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
        
    }
}
