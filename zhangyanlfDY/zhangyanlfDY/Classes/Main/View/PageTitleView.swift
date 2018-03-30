//
//  PageTitleView.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/28.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit
//MARK: - 定义协议
protocol PageTitleViewDelegate : class  {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}
//MARK: - 定义常量
private let zScrollLineH: CGFloat = 2
private let zNormolColor: (CGFloat,CGFloat,CGFloat) = (85, 85 ,85)
private let zSelectedlColor: (CGFloat,CGFloat,CGFloat) = (225, 128 ,0)

//MARK: - 定义PageTitleView类
class PageTitleView: UIView {

    //MARK: - 定义属性
    private var currentIndex: Int = 0
    private var titles : [String]
    weak var delegate: PageTitleViewDelegate?
    //MARK: - 懒加载属性
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
    
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    //Mark: - 自定义构造函数
     init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面

extension PageTitleView {
    
    private func setupUI() {
        //1.添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title的对于label
        setupTitlesLabels()
        
        //3.设置底线和滚动模块
        setupButtonMenuAndScrollLine()
    }
    
    @objc private func setupTitlesLabels(){
            //0.确定label frame 一些常量
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - zScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建Label
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textColor = UIColor(r: zNormolColor.0, g: zNormolColor.1, b: zNormolColor.2)
            label.textAlignment = .center
            
            //3.设置label的frame
             let labelX: CGFloat = labelW * CGFloat (index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将label添加到ScrollView上
            scrollView.addSubview(label)
            titleLabels.append(label)
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupButtonMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect (x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        
        //2.添加ScrollViewLine
        //2.1 获取第一个Label
        guard let fristLabel = titleLabels.first else {
            return
        }
        fristLabel.textColor = UIColor(r: zSelectedlColor.0, g: zSelectedlColor.1, b: zSelectedlColor.2)
        //2.2 设置ScrollViewLine属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - zScrollLineH, width: fristLabel.frame.width, height: zScrollLineH)
        
    }
}
//MARK: - 监听label点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
    
        
        //0.获取当前label的当前值
       guard let currentLabel = tapGes.view as? UILabel else {return}
         //1.判断如果是重复点击同一个title 直接返回
        if currentLabel.tag == currentIndex { return }
        //2.获取之前label
        let oldLabel = titleLabels[currentIndex]
        //3.切换颜色
        currentLabel.textColor = UIColor(r: zSelectedlColor.0, g: zSelectedlColor.1, b: zSelectedlColor.2)
        oldLabel.textColor = UIColor(r: zNormolColor.0, g: zNormolColor.1, b: zNormolColor.2)
        //4.保存最新的label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置变化
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK: - 对外暴露的方法

extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat,sourceIndex: Int,targetIndex: Int)
    {
        //1.取出sourceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        
        //3.颜色的渐变
        //3.1 取出颜色变化的范围
        let colorDtleta = (zSelectedlColor.0 - zNormolColor.0, zSelectedlColor.1 - zNormolColor.1, zSelectedlColor.2 - zNormolColor.2)
        
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: zSelectedlColor.0 - colorDtleta.0 * progress, g: zSelectedlColor.1 - colorDtleta.1 * progress, b: zSelectedlColor.2 - colorDtleta.2 * progress)
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: zNormolColor.0 + colorDtleta.0 * progress, g: zNormolColor.1 + colorDtleta.1 * progress, b: zNormolColor.2 + colorDtleta.2 * progress)
        
        //记录最新的index
        currentIndex = targetIndex
        
        
    }
}









