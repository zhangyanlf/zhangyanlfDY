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
private let zItemH: CGFloat = zItemW * 3 / 4
private let zHeaderViewH: CGFloat = 50

private let zNormalCellID = "zNormalCellID"
private let zHeaderViewID = "zHeaderViewID"

class ZLCommendViewController: UIViewController {

    //懒加载我属性
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: zItemW, height: zItemH)
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
        collectionView.register(UINib(nibName: "ZLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: zHeaderViewID)
        return collectionView
        
       
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI内容
        setupUI()
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
extension ZLCommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zNormalCellID, for: indexPath) as! ZLCollectionNormalCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: zHeaderViewID, for: indexPath)
        
        return headerView
        
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension ZLCommendViewController: UICollectionViewDelegate {
    
}



























