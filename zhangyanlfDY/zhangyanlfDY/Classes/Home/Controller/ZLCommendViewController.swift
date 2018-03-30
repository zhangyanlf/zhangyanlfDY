//
//  ZLCommendViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
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

class ZLCommendViewController: UIViewController {

    //懒加载我属性
    private lazy var commenViewModel: ZLCommenViewModel = ZLCommenViewModel()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI内容
        setupUI()
        //2.发送网络请求
        loadData()
    }

}
//MARK: - 发送网络请求
extension ZLCommendViewController {
    private func loadData() {
        commenViewModel.requestData {
            self.collectionView.reloadData()
        }
    }
}
//MARK - 设置UI界面内容
extension ZLCommendViewController {
    private func setupUI() {
        //添加collectionView
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDataSource
extension ZLCommendViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return commenViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = commenViewModel.anchorGroups[section]
        return group.anchors.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型对象
        let group = commenViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //2.定义Cell
        var cell : ZLCollectionBaseCell!
        
        
        
        if indexPath.section == 1 {
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: zPrettyCellID, for: indexPath) as! ZLCollectionPrettyCell
            
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: zNormalCellID, for: indexPath) as! ZLCollectionNormalCell
        }
        
        
        //3.赋值
        cell.anchor = anchor
        //返回Cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: zHeaderViewID, for: indexPath) as! ZLCollectionHeaderView
        headerView.group = self.commenViewModel.anchorGroups[indexPath.section]
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: zItemW, height: zPrettyItemH)
        } else {
            return CGSize(width: zItemW, height: zNormalItemH)
        }
    }
    
    
}




























