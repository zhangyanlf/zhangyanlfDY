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

class ZLGameViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var zlGameVM : ZLGameViewModel = ZLGameViewModel()
    
    fileprivate lazy var collactionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: zItemW, height: zItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: zEndgeMargin, bottom: 0, right: zEndgeMargin)
        
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
        
        //设置UI界面
        setupUI()
        //加载数据
        loadGameData()
       
    }
}


//MARK: - 设置UI界面
extension ZLGameViewController {
    //1.添加
    private func setupUI (){
        view.addSubview(collactionView)
    }
}

//MARK: - 加载游戏数据
extension ZLGameViewController {
    func loadGameData() {
        zlGameVM.loadAllGameData {
            self.collactionView.reloadData()
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
   
}






