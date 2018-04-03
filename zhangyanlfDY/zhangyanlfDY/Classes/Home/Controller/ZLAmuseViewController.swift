//
//  ZLAmuseViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zItemmargin: CGFloat = 10
private let zItemW: CGFloat = (zScreenW - 3 * zItemmargin) / 2
private let zNormalItemH: CGFloat = zItemW * 3 / 4
private let zPrettyItemH: CGFloat = zItemW * 4 / 3
private let zHeaderViewH: CGFloat = 50

private let zNormalCellID = "zNormalCellID"
private let zPrettyCellID = "zPrettyCellID"
private let zHeaderViewID = "zHeaderViewID"

class ZLAmuseViewController: UIViewController {
    
    //MARK: -  懒加载属性
    fileprivate lazy var zlAmuseVM : ZLAmuseViewModel = ZLAmuseViewModel()
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: zItemW, height: zNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = zItemmargin
        layout.headerReferenceSize = CGSize(width: zScreenW, height: zHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: zItemmargin, bottom: 0, right: zItemmargin)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName:"ZLCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: zNormalCellID)
        collectionView.register(UINib(nibName:"ZLCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: zPrettyCellID)
        collectionView.register(UINib(nibName: "ZLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: zHeaderViewID)
        return collectionView
        
        
        }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        //设置UI界面
        setupUI()
        //发送网络请求
        loadData()
    }

}

//MARK: - 发送网络请求
extension ZLAmuseViewController {
    fileprivate func loadData(){
        zlAmuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - 设置UI界面
extension ZLAmuseViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}


//MARK: - 遵守代理 UICollectionViewDataSource,UICollectionViewDelegate
extension ZLAmuseViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return zlAmuseVM.anchorGroup.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zlAmuseVM.anchorGroup[section].anchors.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zNormalCellID, for: indexPath) as! ZLCollectionNormalCell
        
        cell.anchor = zlAmuseVM.anchorGroup[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: zHeaderViewID, for: indexPath) as! ZLCollectionHeaderView
        headerView.group = zlAmuseVM.anchorGroup[indexPath.section]
        return headerView
    }
    
    
}




