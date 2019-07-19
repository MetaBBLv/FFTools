//
//  FFBottom-upView.m
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import "FFBottom-upView.h"
#import "FFBottom-upTableViewCell.h"

@interface FFBottom_upView ()<UITableViewDelegate, UITableViewDataSource>
///阴影层 ***************************************************************************
@property (nonatomic, strong) UIView *shadowView;
///移除层 ***************************************************************************
@property (nonatomic, strong) UIButton *removeBtn;
///展示层 ***************************************************************************
@property (nonatomic, strong) UIView *showView;
///弹框标题
@property (nonatomic, strong) UILabel *titleLabel;
///弹框描述：可省略
@property (nonatomic, strong) UILabel *descriptLabel;
///关闭弹框
@property (nonatomic, strong) UIButton *exitBtn;
///数据列表
@property (nonatomic, strong) UITableView *tableView;
///数据
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation FFBottom_upView

#pragma mark - private Method
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Description:(NSString *)description DataArray:(NSArray *)dataArray {
    if (self = [super init]) {
        [self customShadowView];
        [self customViewWithTitle:title Description:description DataArray:dataArray];
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
        self.showView.frame = CGRectMake(0, SCREEN_HEIGHT- 380/WIDTH_6_SCALE, SCREEN_WIDTH, 380/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)customViewWithTitle:(NSString *)title Description:(NSString *)description DataArray:(NSArray *)dataArray {
    self.titleLabel.text = title;
    self.descriptLabel.text = description;
    self.dataArray = dataArray;
}

#pragma mark - lazyloading
- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 380/WIDTH_6_SCALE)];
        _removeBtn.backgroundColor = [UIColor clearColor];
        [_removeBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 380/WIDTH_6_SCALE)];
        _showView.backgroundColor = [UIColor colorWithRed:0.20 green:0.18 blue:0.29 alpha:1.00];
        [_showView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10/WIDTH_6_SCALE);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20/WIDTH_6_SCALE);
        }];
        [_showView addSubview:self.descriptLabel];
        [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10/WIDTH_6_SCALE);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20/WIDTH_6_SCALE);
        }];
        [_showView addSubview:self.exitBtn];
        [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10/WIDTH_6_SCALE);
            make.right.mas_equalTo(-10/WIDTH_6_SCALE);
            make.size.mas_equalTo(CGSizeMake(15/WIDTH_6_SCALE, 15/WIDTH_6_SCALE));
        }];
        [_showView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descriptLabel.mas_bottom).with.offset(10/WIDTH_6_SCALE);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _showView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [[UILabel alloc] init];
        _descriptLabel.textColor = [UIColor whiteColor];
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
        _descriptLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descriptLabel;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] init];
        [_exitBtn setImage:[UIImage imageNamed:@"icon_exit_32*32_"] forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[FFBottom_upTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FFBottom_upTableViewCell class])];
    }
    return _tableView;
}

#pragma mark - layout
- (void)layout {
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100/WIDTH_6_SCALE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFBottom_upTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FFBottom_upTableViewCell class])];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setGoEvaluationToCellBlock:^{
        if (self.goEvaluationBlock) {
            self.goEvaluationBlock(indexPath.row);
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellBlock) {
        self.cellBlock(indexPath.row);
    }
}

#pragma mark - event response
- (void)exitBtnAction{
    //关闭
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        self.showView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 380/WIDTH_6_SCALE);
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        if (self.exitBlock) {
            self.exitBlock();
        }
    }];
}
@end
