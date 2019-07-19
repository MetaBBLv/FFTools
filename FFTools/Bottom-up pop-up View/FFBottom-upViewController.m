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
///阴影层
@property (nonatomic, strong) UIView *shadowView;
///展示层
@property (nonatomic, strong) FFBottom_upView *bottom_upView;
///移除层
@property (nonatomic, strong) UIButton *removeBtn;

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
    _shadowView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [_shadowView addSubview:self.removeBtn];
    [_shadowView addSubview:self.bottom_upView];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_upView.frame = CGRectMake(0, SCREEN_HEIGHT- 380/WIDTH_6_SCALE, SCREEN_WIDTH, 380/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        
    }];
}

- (FFBottom_upView *)bottom_upView {
    if (!_bottom_upView) {
        _bottom_upView = [[FFBottom_upView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 380/WIDTH_6_SCALE) Title:@"请选择要评价的商品"    Description:@"较好的评价有助于其他的朋友更好的了解" DataArray:@[@"1",@"2",@"3"]];
        _bottom_upView.backgroundColor = [UIColor colorWithRed:0.20 green:0.18 blue:0.29 alpha:1.00];
        kWeakSelf(self);
        [_bottom_upView setExitBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                weakself.bottom_upView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 380/WIDTH_6_SCALE);
            } completion:^(BOOL finished) {
                [weakself.shadowView removeFromSuperview];
            }];
        }];
    }
    return _bottom_upView;
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 380/WIDTH_6_SCALE)];
        _removeBtn.backgroundColor = [UIColor clearColor];
        [_removeBtn addTarget:self action:@selector(removeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

#pragma mark - event response
- (void)removeBtnAction {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottom_upView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 380/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
    }];
}

@end
