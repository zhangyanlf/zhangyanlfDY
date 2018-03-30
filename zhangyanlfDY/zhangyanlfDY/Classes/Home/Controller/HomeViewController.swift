//
//  HomeViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/27.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

private let zTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    //Mark: - 懒加载属性
    private lazy var  pageTitleView : PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: zStatusBarH + zNavigationBarH, width: zScreenW, height: zTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的frame
        let zContentH = zScreenH - zStatusBarH - zNavigationBarH - zTitleViewH - zTabbarH
        let contentFrame = CGRect(x: 0, y: zStatusBarH + zNavigationBarH + zTitleViewH, width: zScreenW, height: zContentH)
        //2.确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(ZLCommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
            
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.设置界面
        setupUI()
        
        
        
    }


}





//MARK: - 设置UI界面
extension HomeViewController {
    
    private func setupUI() {
        //0.不需要ScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        //2.添加titleView
        view.addSubview(pageTitleView)
        //3.添加contentView
        view.addSubview(pageContentView)
//        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar () {
        
        //1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的item
        let size = CGSize.init(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
        
        
        
    }
    

}

//MARK: - 遵守PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守PageContentViewDelegete

extension HomeViewController: PageContentViewDelegete {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}











