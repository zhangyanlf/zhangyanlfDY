//
//  ZLBaseViewController.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/4.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLBaseViewController: UIViewController {
    
    //MARK: - 定义属性
    var contentView : UIView?
    
    
    //MARK: - 懒加载属性
    fileprivate lazy var animImageView: UIImageView = {[unowned self] in
        let animImageView = UIImageView(image: UIImage(named: "img_loading_1"))
        animImageView.center = self.view.center
        animImageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        animImageView.animationDuration = 0.5
        animImageView.animationRepeatCount = LONG_MAX
        animImageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return animImageView
    }()

    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ZLBaseViewController {
    @objc func setupUI() {
        
        //1.隐藏展示内容view
        contentView?.isHidden = true
        //2.添加执行动画的UI
        view.addSubview(animImageView)
        //3.给animImageView执行动画
        animImageView.startAnimating()
        //4.设置背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
        //2.设置 animImageView 隐藏
        animImageView.isHidden = true
        //3.显示内容的view
        contentView?.isHidden = false
        
    }
}





