//
//  ZLAmuseViewModel.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/4/3.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit


class ZLAmuseViewModel : ZLBaseViewModel {

    
}

extension ZLAmuseViewModel {
    func loadAmuseData(finishedCallBack:@escaping () -> ()) {
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallBack)
    }
}
