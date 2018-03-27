//
//  UIBarbuttonItem+Extension.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/27.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    class func createItem(imageName: String, highImageName: String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
}
