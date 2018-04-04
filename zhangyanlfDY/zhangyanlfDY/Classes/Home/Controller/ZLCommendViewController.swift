//
//  ZLCommendViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zCycleViewH :CGFloat = zScreenW * 3 / 8
private let zGameViewH :CGFloat = 90

class ZLCommendViewController: ZLBaseAnchorController {

    //MARK: -  懒加载属性
    private lazy var commenViewModel: ZLCommenViewModel = ZLCommenViewModel()
    
    
    private lazy var cycleView : ZLRecommendCycleView = {
       let cycleView = ZLRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(zCycleViewH + zGameViewH), width: zScreenW, height: zCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView : ZLCommendGameView = {
        let gameView = ZLCommendGameView.zlcommendGameView()
        gameView.frame = CGRect(x: 0, y: -zGameViewH, width: zScreenW, height: zGameViewH)
        return gameView
    }()

}
//MARK: - 发送网络请求
extension ZLCommendViewController {
    override func loadData() {
        //0.给父类中的baseVM赋值
        baseVM = commenViewModel
        //1.请求推荐数据
        commenViewModel.requestData {
            //1.1展示推荐数据
            self.collectionView.reloadData()
            //1.2 将数据传给GameView
            var groups = self.commenViewModel.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            //2.添加更多数据
            let moreGroup = ZLAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
        }
        //2.请求轮播数据
        commenViewModel.requestCycleDat {
            self.cycleView.cycleModels = self.commenViewModel.cycleModels
        }
    }
}
//MARK - 设置UI界面内容
extension ZLCommendViewController {
     override func setupUI() {
        //1.先调用super.setupUI()
        super.setupUI()
        //2.将cycleView添加到collectionView
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加到collectionView
        collectionView.addSubview(gameView)
        //4.创建collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: zCycleViewH + zGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 子类实现方法
extension ZLCommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: zPrettyCellID, for: indexPath) as! ZLCollectionPrettyCell
            //2.赋值
            cell.anchor = commenViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
            
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: zItemW, height: zPrettyItemH)
        } else {
            return CGSize(width: zItemW, height: zNormalItemH)
        }
    }
}


























