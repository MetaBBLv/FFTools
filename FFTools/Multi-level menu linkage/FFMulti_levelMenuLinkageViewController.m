//
//  FFMainViewController.m
//  bosheng
//
//  Created by zhou on 2019/12/14.
//  Copyright © 2019 bosheng. All rights reserved.
//

#import "FFMulti_levelMenuLinkageViewController.h"
#import "FFCategoryView.h"
#import "httpManager.h"
#import "SVProgressHUD.h"

@interface FFMulti_levelMenuLinkageViewController ()
{
    NSArray * allArray;
}
@property (nonatomic, strong) FFCategoryView *categoryView;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation FFMulti_levelMenuLinkageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Multi-level menu linkage";
    [self getData];
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    [self.btn setTitle:@"弹出" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor redColor];
    [self.btn addTarget:self action:@selector(aaaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
}

- (void)aaaa {
    self.categoryView = [[FFCategoryView alloc] initWithFrame:UIScreen.mainScreen.bounds data:allArray];
    kWeakSelf(self);
    ///退出底部弹框
    [self.categoryView setExitBlock:^{
        [weakself.categoryView removeFromSuperview];
    }];
    [self.categoryView setSubmitBlock:^(NSString * _Nonnull detail) {
        [weakself.btn setTitle:detail forState:UIControlStateNormal];
        [weakself.categoryView removeFromSuperview];
    }];
    
}

- (void)getData {
    [httpManager requestWithURLString:@"https://test.chaojihaixing.com/starfish/caseinquirytype/alllist" parameters:nil type:HttpRequestTypePost success:^(id responseObject) {
        if ([responseObject[@"returnCode"] isEqualToString:@"6006"]) {
            self->allArray = responseObject[@"data"][@"caseInquiryTypes"];
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器错误"];
    }];
}
@end
