//
//  FFMiddle-upViewController.m
//  FFTools
//
//  Created by zhou on 2019/11/21.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import "FFMiddle-upViewController.h"
#import "FFMiddle-upView.h"

@interface FFMiddle_upViewController ()
///展示层
@property (nonatomic, strong) FFMiddle_upView *middle_upView;
@end

@implementation FFMiddle_upViewController

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
    
    _middle_upView = [[FFMiddle_upView alloc] initWithFrame:UIScreen.mainScreen.bounds Title:@"绑定手机"];
    kWeakSelf(self);
    ///退出底部弹框
    [_middle_upView setExitBlock:^{
        [weakself.middle_upView removeFromSuperview];
    }];
//
//    ///响应cell点击
//    [_bottom_upView setCellBlock:^(NSInteger index) {
//        NSLog(@"响应cell点击：第%ld个cell",(long)index);
//    }];
//
//    ///响应cell内Button点击
//    [_bottom_upView setGoEvaluationBlock:^(NSInteger index) {
//        NSLog(@"响应cell内Button点击：第%ld个cell内button",(long)index);
//    }];
}

@end
