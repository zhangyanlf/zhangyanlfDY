//
//  ZLAmuseMenuView.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/4.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zAuMenuCellID = "zAuMenuCellID"

class ZLAmuseMenuView: UIView {
    //MARK: - 定义属性
    var groups : [ZLAnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 从Xib中加载出来
    override func awakeFromNib() {
        
        collectionView.register(UINib(nibName: "ZLAmusemenuCell", bundle: nil), forCellWithReuseIdentifier: zAuMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
        
        
    }
    
}
extension ZLAmuseMenuView {
    class func zlAmuseMenuView () -> ZLAmuseMenuView {
        return Bundle.main.loadNibNamed("ZLAmuseMenuView", owner: nil, options: nil)?.first as! ZLAmuseMenuView
    }
}

extension ZLAmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zAuMenuCellID, for: indexPath) as! ZLAmusemenuCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    
    private func setupCellDataWithCell(cell: ZLAmusemenuCell, indexPath: IndexPath) {
        //1.第0页 0~7
        //第1页 8~ 15
         //第1页 16~ 23
        
        //1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //2.判断越界问题
        if endIndex > (groups?.count)! - 1 {
            endIndex = (groups?.count)! - 1
        }
        
        //3.取出数据，赋值
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
    
}

extension ZLAmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}


