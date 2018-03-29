# zhangyanlfDY
Swift版的斗鱼直播项目

# 项目搭建
使用Swift4语言开发，采用Sb+代码实现功能

## 主架构
采用Sb搭建,使用Refactor 分割Sb，分别管理Sb界面

## 首页

封装顶部滚动分段器及底部滚动界面，实现分段器及底部滚动界面同步滑动。


## 顶部分段器
``` iOS
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
        
    }
```

## Label颜色渐变效果
```
				//3.颜色的渐变
        //3.1 取出颜色变化的范围
        let colorDtleta = (zSelectedlColor.0 - zNormolColor.0, zSelectedlColor.1 - zNormolColor.1, zSelectedlColor.2 - zNormolColor.2)
        
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: zSelectedlColor.0 - colorDtleta.0 * progress, g: zSelectedlColor.1 - colorDtleta.1 * progress, b: zSelectedlColor.2 - colorDtleta.2 * progress)
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: zNormolColor.0 + colorDtleta.0 * progress, g: zNormolColor.1 + colorDtleta.1 * progress, b: zNormolColor.2 + colorDtleta.2 * progress)
```

## 页面具体实现分段器及界面滚动，详细代码(暴露方法、代理方法等)请查看项目中具体代码
