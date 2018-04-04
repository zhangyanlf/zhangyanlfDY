//
//  ZLFunnyViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/4.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zTopmargin: CGFloat = 8

class ZLFunnyViewController: ZLBaseAnchorController {
    //MARK: - 懒加载FunnyViewModel对象
    fileprivate lazy var zlFunnyVM : ZLFunnyviewModel = ZLFunnyviewModel()

}

extension ZLFunnyViewController {
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: zTopmargin, left: 0, bottom: 0, right: 0)
        
        
    }
}

extension ZLFunnyViewController {
    override func loadData() {
        //1.给父类中的ViewModel赋值
        baseVM = zlFunnyVM
        
        //2.请求数据
        zlFunnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}





