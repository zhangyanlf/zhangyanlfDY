//
//  ZLGameViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/2.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zEndgeMargin: CGFloat = 10
private let zItemW: CGFloat = (zScreenW - 2 * zEndgeMargin) / 3
private let zItemH: CGFloat = zItemW * 6 / 5
private let zGameCellID = "zGameCellID"
private let zGameHeaderID = "zGameHeaderID"
private let zHeaderH: CGFloat = 50

private let zAGameViewH: CGFloat = 90
class ZLGameViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var topHeaderView : ZLCollectionHeaderView = {
       let topHeaderView = ZLCollectionHeaderView.colectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(zHeaderH + zAGameViewH), width: zScreenW, height: zHeaderH)
        topHeaderView.iconImage.image = UIImage(named: "Img_orange")
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.moreButton.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var alawaysGameView : ZLCommendGameView = {
        let alawaysGameView = ZLCommendGameView.zlcommendGameView()
        alawaysGameView.frame = CGRect(x: 0, y: -zAGameViewH, width: zScreenW, height: zAGameViewH)
        return alawaysGameView
    }()
    
    fileprivate lazy var zlGameVM : ZLGameViewModel = ZLGameViewModel()
    
    fileprivate lazy var collactionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: zItemW, height: zItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: zEndgeMargin, bottom: 0, right: zEndgeMargin)
        layout.headerReferenceSize = CGSize(width: zScreenW, height: zHeaderH)
        
        //2.创建collactionView
       let collactionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collactionView.backgroundColor = UIColor.white
        collactionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return collactionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //注册Cell
        collactionView.register(UINib(nibName: "ZLCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: zGameCellID)
        collactionView.dataSource = self
        
        //注册headerView
        collactionView.register(UINib(nibName: "ZLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: zGameHeaderID)
        
        //设置UI界面
        setupUI()
        //加载数据
        loadGameData()
       
    }
}


//MARK: - 设置UI界面
extension ZLGameViewController {
    
    private func setupUI (){
        //1.添加 collactionView
        view.addSubview(collactionView)
        
        //2.添加顶部的topHeaderView
        collactionView.addSubview(topHeaderView)
        
        //3.设置collactionView的内边距
        collactionView.contentInset = UIEdgeInsets(top: zHeaderH + zAGameViewH, left: 0, bottom: 0, right: 0)
        
        //4.将alawaysGameView 添加到 collactionView
        collactionView.addSubview(alawaysGameView)
    }
}

//MARK: - 加载游戏数据
extension ZLGameViewController {
    func loadGameData() {
        zlGameVM.loadAllGameData {
            //1.展示全部游戏
            self.collactionView.reloadData()
            
            //2.展示前10跳数据
            self.alawaysGameView.gameGroups = Array(self.zlGameVM.games[0..<10])
        
        }
    }
}

//MARK: - 遵守UICollectionViewDataSource
extension ZLGameViewController : UICollectionViewDataSource{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zlGameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collactionView.dequeueReusableCell(withReuseIdentifier: zGameCellID, for: indexPath) as! ZLCollectionGameCell
        cell.gameModel = zlGameVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collactionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: zGameHeaderID, for: indexPath) as! ZLCollectionHeaderView
        //2.headerView 设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImage.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        return headerView
    }
   
}






