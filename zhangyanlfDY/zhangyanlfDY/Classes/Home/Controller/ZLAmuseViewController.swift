//
//  ZLAmuseViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zMenuViewH: CGFloat = 200

class ZLAmuseViewController: ZLBaseAnchorController {
    
    //MARK: -  懒加载属性
    fileprivate lazy var zlAmuseVM : ZLAmuseViewModel = ZLAmuseViewModel()
    fileprivate lazy var zlAumseMenuView : ZLAmuseMenuView = {
        let zlAumseMenuView = ZLAmuseMenuView.zlAmuseMenuView()
        zlAumseMenuView.frame = CGRect(x: 0, y: -zMenuViewH, width: zScreenW, height: zMenuViewH)

        
        return zlAumseMenuView
    }()

}

//MARK: - 设置UI界面
extension ZLAmuseViewController {
    override func setupUI() {
        super.setupUI()
        //2.将菜单的View添加到collectionView中
        collectionView.addSubview(zlAumseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: zMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 加载数据
extension ZLAmuseViewController {
    override func loadData() {
        //1.给父类中的baseVM赋值
        baseVM = zlAmuseVM
        //2.请求数据
        zlAmuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroups = self.zlAmuseVM.anchorGroups
            tempGroups.removeFirst()
            
            self.zlAumseMenuView.groups = tempGroups
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






