//
//  ZLAmuseViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit



class ZLAmuseViewController: ZLBaseAnchorController {
    
    //MARK: -  懒加载属性
    fileprivate lazy var zlAmuseVM : ZLAmuseViewModel = ZLAmuseViewModel()

}

extension ZLAmuseViewController {
    override func loadData() {
        //1.给父类中的baseVM赋值
        baseVM = zlAmuseVM
        
        zlAmuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - 子类实现方法
extension ZLAmuseViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == (zlAmuseVM.anchorGroups.count - 1) {
            //1.取出cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zPrettyCellID, for: indexPath) as! ZLCollectionPrettyCell
            //2.赋值
            cell.anchor = zlAmuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
            
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == (zlAmuseVM.anchorGroups.count - 1) {
            return CGSize(width: zItemW, height: zPrettyItemH)
        } else {
            return CGSize(width: zItemW, height: zNormalItemH)
        }
    }
}






