//
//  ZLBaseAnchorController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

let zItemmargin: CGFloat = 10
let zItemW: CGFloat = (zScreenW - 3 * zItemmargin) / 2
let zNormalItemH: CGFloat = zItemW * 3 / 4
let zPrettyItemH: CGFloat = zItemW * 4 / 3
let zHeaderViewH: CGFloat = 50

private let zNormalCellID = "zNormalCellID"
let zPrettyCellID = "zPrettyCellID"
private let zHeaderViewID = "zHeaderViewID"

class ZLBaseAnchorController: ZLBaseViewController {

        //MARK: - 定义属性
        var baseVM : ZLBaseViewModel!
    
        lazy var collectionView: UICollectionView = { [weak self] in
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
        //设置UI界面
        setupUI()
        //发送网络请求
        loadData()
        
    }
}

//MARK: - 发送网络请求
extension ZLBaseAnchorController {
     @objc func loadData(){
    }
}
//MARK: - 设置UI界面
extension ZLBaseAnchorController {
     override func setupUI() {
        //1.给父类中的View引用进行赋值
        contentView = collectionView
        //2.添加 collectionView
        view.addSubview(collectionView)
        //3.调用super.setupUI()
        super.setupUI()
        
    }
}
//MARK: - 遵守代理 UICollectionViewDataSource,UICollectionViewDelegate
extension ZLBaseAnchorController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zNormalCellID, for: indexPath) as! ZLCollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: zHeaderViewID, for: indexPath) as! ZLCollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    
}


