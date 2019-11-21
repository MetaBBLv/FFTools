//
//  FFMiddle-upView.m
//  FFTools
//
//  Created by zhou on 2019/11/21.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import "FFMiddle-upView.h"

@interface FFMiddle_upView ()
//!阴影层 ***************************************************************************
@property (nonatomic, strong) UIView *shadowView;
//!移除层 ***************************************************************************
@property (nonatomic, strong) UIButton *removeBtn;
//!展示层 ***************************************************************************
@property (nonatomic, strong) UIView *showView;
//!弹框标题
@property (nonatomic, strong) UILabel *titleLabel;
//!关闭弹框
@property (nonatomic, strong) UIButton *exitBtn;
//!手机号图片
@property (nonatomic, strong) UIImageView *phoneIcon;
//!手机号输入框
@property (nonatomic, strong) UITextField *phoneTextField;
//!验证码图片
@property (nonatomic, strong) UIImageView *codeIcon;
//!验证码输入框
@property (nonatomic, strong) UITextField *codeTextField;
//!获取验证码
@property (nonatomic, strong) UIButton *codeBtn;
//!确定
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation FFMiddle_upView
#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title {
    if (self = [super init]) {
        [self customShadowView];
        [self customViewWithTitle:title];
    }
    return self;
}

#pragma mark - private method
- (void)customShadowView {
    _shadowView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [_shadowView addSubview:self.removeBtn];
    [_shadowView addSubview:self.showView];
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.showView.frame = CGRectMake(50/WIDTH_6_SCALE, SCREEN_HEIGHT- 500/WIDTH_6_SCALE, SCREEN_WIDTH - 100/WIDTH_6_SCALE, 260/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)customViewWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - lazyloading
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(50/WIDTH_6_SCALE, SCREEN_HEIGHT, SCREEN_WIDTH - 100/WIDTH_6_SCALE, 260/WIDTH_6_SCALE)];
        _showView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.00];
        _showView.layer.cornerRadius = 5/WIDTH_6_SCALE;
        _showView.layer.masksToBounds = YES;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
        
        [_showView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20/WIDTH_6_SCALE);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20/WIDTH_6_SCALE);
        }];
        [_showView addSubview:self.exitBtn];
        [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20/WIDTH_6_SCALE);
            make.right.mas_equalTo(-20/WIDTH_6_SCALE);
            make.size.mas_equalTo(CGSizeMake(20/WIDTH_6_SCALE, 20/WIDTH_6_SCALE));
        }];
        [_showView addSubview:self.phoneIcon];
        [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10/WIDTH_6_SCALE);
            make.left.mas_equalTo(20/WIDTH_6_SCALE);
            make.size.mas_equalTo(CGSizeMake(15/WIDTH_6_SCALE, 50/WIDTH_6_SCALE));
        }];
        [_showView addSubview:self.phoneTextField];
        [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10/WIDTH_6_SCALE);
            make.left.equalTo(self.phoneIcon.mas_right).with.offset(8/WIDTH_6_SCALE);
            make.right.mas_equalTo(-20/WIDTH_6_SCALE);
            make.height.mas_equalTo(50/WIDTH_6_SCALE);
        }];
        [_showView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(0);
            make.left.mas_equalTo(20/WIDTH_6_SCALE);
            make.right.mas_equalTo(-20/WIDTH_6_SCALE);
            make.height.mas_equalTo(.5);
        }];
        [_showView addSubview:self.codeIcon];
        [self.codeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).with.offset(0);
            make.left.mas_equalTo(20/WIDTH_6_SCALE);
            make.size.mas_equalTo(CGSizeMake(15/WIDTH_6_SCALE, 50/WIDTH_6_SCALE));
        }];
        [_showView addSubview:self.codeBtn];
        [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).with.offset(10/WIDTH_6_SCALE);
            make.right.mas_equalTo(-20/WIDTH_6_SCALE);
            make.size.mas_equalTo(CGSizeMake(100/WIDTH_6_SCALE, 30/WIDTH_6_SCALE));
        }];
        [_showView addSubview:self.codeTextField];
        [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).with.offset(0);
            make.left.equalTo(self.codeIcon.mas_right).with.offset(8/WIDTH_6_SCALE);
            make.right.equalTo(self.codeBtn.mas_left).with.offset(-5/WIDTH_6_SCALE);
            make.height.mas_equalTo(50/WIDTH_6_SCALE);
        }];
        [_showView addSubview:self.submitBtn];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.codeTextField.mas_bottom).with.offset(35/WIDTH_6_SCALE);
            make.left.mas_equalTo(20/WIDTH_6_SCALE);
            make.right.mas_equalTo(-20/WIDTH_6_SCALE);
            make.height.mas_equalTo(40/WIDTH_6_SCALE);
        }];
    }
    return _showView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] init];
        [_exitBtn setImage:[UIImage imageNamed:@"icon_exit"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

- (UIImageView *)phoneIcon {
    if (!_phoneIcon) {
        _phoneIcon = [[UIImageView alloc] init];
        _phoneIcon.contentMode = UIViewContentModeScaleAspectFit;
        _phoneIcon.image = [UIImage imageNamed:@"icon_phone"];
    }
    return _phoneIcon;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.font = SYSTEMFONT(12);
        _phoneTextField.textColor = [UIColor blackColor];
    }
    return _phoneTextField;
}

- (UIImageView *)codeIcon {
    if (!_codeIcon) {
        _codeIcon = [[UIImageView alloc] init];
        _codeIcon.contentMode = UIViewContentModeScaleAspectFit;
        _codeIcon.image = [UIImage imageNamed:@"icon_code"];
    }
    return _codeIcon;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTextField.font = SYSTEMFONT(12);
        _codeTextField.textColor = [UIColor blackColor];
    }
    return _codeTextField;
}

- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [[UIButton alloc] init];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor colorWithHexString:@"e69d42"] forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = SYSTEMFONT(12);
        _codeBtn.layer.cornerRadius = 3;
        _codeBtn.layer.borderWidth = .5;
        _codeBtn.layer.borderColor = [UIColor colorWithHexString:@"e69d42"].CGColor;
        _codeBtn.layer.masksToBounds = YES;
        [_codeBtn addTarget:self action:@selector(getCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor colorWithHexString:@"e69d42"]];
        _submitBtn.titleLabel.font = SYSTEMFONT(17);
        _submitBtn.layer.cornerRadius = 3;
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn addTarget:self action:@selector(getSubmitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

#pragma mark - event response
- (void)exitBtnAction{
    //关闭
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        self.showView.frame = CGRectMake(50/WIDTH_6_SCALE, SCREEN_HEIGHT, SCREEN_WIDTH - 100/WIDTH_6_SCALE, 260/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        if (self.exitBlock) {
            self.exitBlock();
        }
    }];
}

/// 获取验证码
/// @param sender sender
- (void)getCodeBtnAction:(UIButton *)sender {
    
}

///  确定
/// @param sender sender
- (void)getSubmitBtnAction:(UIButton *)sender {
    if (self.submitBlock) {
        self.submitBlock();
    }
}
@end
