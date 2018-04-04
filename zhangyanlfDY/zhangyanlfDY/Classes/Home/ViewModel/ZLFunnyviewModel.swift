//
//  ZLFunnyviewModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/4.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit

class ZLFunnyviewModel: ZLBaseViewModel {

}

extension ZLFunnyviewModel {
    func loadFunnyData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: false, urlString: "http://api.douyutv.com/api/v1/live") {
            finishedCallback()
        }
    }
}
