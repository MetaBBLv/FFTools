//
//  FFBottom-upViewController.m
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import "FFBottom-upViewController.h"
#import "FFBottom-upView.h"

@interface FFBottom_upViewController ()
///展示层
@property (nonatomic, strong) FFBottom_upView *bottom_upView;

@end

@implementation FFBottom_upViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Bottom-up pop-up View";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 200, self.view.bounds.size.width, 30);
    [btn setTitle:@"弹出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    //弹出
    [self setShadowView];
}

- (void)setShadowView {
    
    _bottom_upView = [[FFBottom_upView alloc] initWithFrame:UIScreen.mainScreen.bounds Title:@"请选择要评价的商品" Description:@"较好的评价有助于其他的朋友更好的了解" DataArray:@[@"1",@"2",@"3"]];
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
}
@end
