# FFTools
此工具集为在工作中遇到的一些问题，整理出来的解决方案

## 前言
此项目是一个长期项目，目的在于解决日常项目中的一些常见问题（例如：弹框、动画），在工作之余，总结了一下，也是一个自我提升的过程，找到了一些以前赶项目，赶工期忽略的一些问题，在此项目中都会标注，并且就涉及到相关知识进行自我梳理，希望可以帮助到同样处于开发的小伙伴。

## 001:Bottom-up pop-up View（自下而上的弹出框）

### 截图：
![image](https://github.com/DidiFly/FFTools/blob/master/FFTools/Bottom-up%20pop-up%20View.gif)

### 说明：
这个demo描述了自页面底部向上的弹出框（也可以是其他方向，根据需求更好就好），涉及到了iOS中常见的响应链

### 使用方法
导入项目中的Bottom-up pop-up View文件夹，在需要弹出框的页面导入```#import "FFBottom-upView.h"```然后初始化该类：
```
 _bottom_upView = [[FFBottom_upView alloc] initWithFrame:UIScreen.mainScreen.bounds Title:@"请选择要评价的商品" Description:@"较好的评价有助于其他的朋友更好的了解" DataArray:@[@"1",@"2",@"3"]];
```
内部有3个响应事件，分别是：退出弹框、弹框内cell点击、弹框内cell内的button点击
```
    kWeakSelf(self);
    ///退出底部弹框
    [_bottom_upView setExitBlock:^{
        [weakself.bottom_upView removeFromSuperview];
    }];
    
    ///响应cell点击
    [_bottom_upView setCellBlock:^(NSInteger index) {
        NSLog(@"响应cell点击：第%ld个cell",(long)index);
    }];
    
    ///响应cell内Button点击
    [_bottom_upView setGoEvaluationBlock:^(NSInteger index) {
        NSLog(@"响应cell内Button点击：第%ld个cell内button",(long)index);
    }];
```

## 002:Middle-up pop-up View（例：绑定手机号弹出框）

### 截图：
![image](https://github.com/DidiFly/FFTools/blob/master/FFTools/Middle-up%20pop-up%20View.gif)

### 说明：
这个demo描述了绑定手机号的弹出框（也可以是其他方向，根据需求更好就好），涉及到了iOS中常见的响应链，Block

### 使用方法
导入项目中的Middle-up pop-up View文件夹，在需要弹出框的页面导入```#import "FFMiddle-upView.h"```然后初始化该类：
```
 _middle_upView = [[FFMiddle_upView alloc] initWithFrame:UIScreen.mainScreen.bounds Title:@"绑定手机"];
```
内部有3个响应事件，分别是：退出弹框、弹框内cell点击、弹框内cell内的button点击
```
    kWeakSelf(self);
    ///退出弹框
    [_middle_upView setExitBlock:^{
        [weakself.middle_upView removeFromSuperview];
    }];
    
    ///确定
    [_middle_upView setSubmitBlock:^{
        NSLog(@"执行操作。。。。。。");
        [weakself.middle_upView removeFromSuperview];
    }];
```

## 003:Multi-level menu linkage（例：多级菜单联动）

### 截图：
![image](https://github.com/DidiFly/FFTools/blob/master/FFTools/%20multilevel-linkage-menu.gif)

### 说明：
这个demo解决了多级菜单联动问题，涉及到了数据的复杂计算，tableView的delegate的全面应用

### 使用方法
导入项目中的Multi-level menu linkage文件夹，在需要弹出框的页面导入```FFMulti_levelMenuLinkageViewController.h"```然后初始化该类：
```
_categoryView = [[FFCategoryView alloc] initWithFrame:UIScreen.mainScreen.bounds data:allArray];
```
内部有2个响应事件，分别是：退出弹框、弹框内的确认选择button点击
```
    kWeakSelf(self);
    ///退出底部弹框
    [self.categoryView setExitBlock:^{
        [weakself.categoryView removeFromSuperview];
    }];
    ///提交选择
    [self.categoryView setSubmitBlock:^(NSString * _Nonnull detail) {
        [weakself.btn setTitle:detail forState:UIControlStateNormal];
        [weakself.categoryView removeFromSuperview];
    }];
 ```

## 持续更新


