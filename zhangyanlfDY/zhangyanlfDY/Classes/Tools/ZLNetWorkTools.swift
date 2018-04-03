//
//  ZLNetWorkTools.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/29.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}


class ZLNetWorkTools{
 
   class func requestDate(type: MethodType, urlString: String,paramters :[String: Any]? = nil,finishedCallback:@escaping (_ result: Any)->()) {
        
        //1.自定义类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //2.发送网络请求
        Alamofire.request(urlString, method: method, parameters: paramters).responseJSON { (response) in
            //3.获取结果
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            //4.将结果回调
            finishedCallback(result)
        }
    
    
    
    }
}
