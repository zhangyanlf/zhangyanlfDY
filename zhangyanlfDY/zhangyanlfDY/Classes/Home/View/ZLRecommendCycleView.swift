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
    var cycleTimer : Timer?
    
    var cycleModels : [ZLCycleModel]? {
        didSet {
            //1.刷新 collectionView
            collectionView.reloadData()
            //2.设置pageControl numberOfPages
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认设置滚动到中间某一位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.
            removeCycleTimer()
            addCycleTimer()
            
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
        return (cycleModels?.count ?? 0) * 10000
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zCycleCellID, for: indexPath) as! ZLCollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % (cycleModels?.count)!]
       
        return cell
        
    }
}
//MARK: - 遵守UICollectionViewDataSource代理
extension ZLRecommendCycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //2.计算pageCotroller 的 currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}

//MARK: - 对定时器的操作方法
extension ZLRecommendCycleView {
    private func addCycleTimer () {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToIndex), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    private func removeCycleTimer () {
        cycleTimer?.invalidate() //从运行循环中移除
        cycleTimer = nil
    }
    @objc private func scrollToIndex() {
        //1.获取滚动的偏移量
        let currretOffsetX = collectionView.contentOffset.x
        let offsetX = currretOffsetX + collectionView.bounds.width
        
        //2.滚动到位置
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        
    }
}

