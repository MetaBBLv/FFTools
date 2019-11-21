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
    
    self.title = @"Middle-up pop-up View";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 200, self.view.bounds.size.width, 30);
    [btn setTitle:@"绑定手机号" forState:UIControlStateNormal];
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
    ///退出弹框
    [_middle_upView setExitBlock:^{
        [weakself.middle_upView removeFromSuperview];
    }];
    
    ///确定
    [_middle_upView setSubmitBlock:^{
        NSLog(@"执行操作。。。。。。");
        [weakself.middle_upView removeFromSuperview];
    }];
}

@end
