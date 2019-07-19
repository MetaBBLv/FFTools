//
//  FFBottom-upTableViewCell.m
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import "FFBottom-upTableViewCell.h"

@interface FFBottom_upTableViewCell ()
@property (nonatomic, strong) UIView *goodsBackgroundView;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIButton *goEvaluationBtn;
@end

@implementation FFBottom_upTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.goodsBackgroundView];
        [self.goodsBackgroundView addSubview:self.goodsImageView];
        [self.goodsBackgroundView addSubview:self.titleLabel];
        [self.goodsBackgroundView addSubview:self.typeLabel];
        [self.goodsBackgroundView addSubview:self.goEvaluationBtn];
        [self layout];
    }
    return self;
}

- (UIView *)goodsBackgroundView {
    if (!_goodsBackgroundView) {
        _goodsBackgroundView = [[UIView alloc] init];
        _goodsBackgroundView.backgroundColor = [UIColor colorWithRed:0.24 green:0.22 blue:0.30 alpha:1.00];
        _goodsBackgroundView.layer.cornerRadius = 5;
        _goodsBackgroundView.layer.masksToBounds = YES;
    }
    return _goodsBackgroundView;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.image = [UIImage imageNamed:@"icon_fish"];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"源枝园味 美国进口黑加仑提子 2kg装 非黑葡萄 新鲜水果";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = SYSTEMFONT(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.text = @"1kg装";
        _typeLabel.textColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.00];
        _typeLabel.font = SYSTEMFONT(12);
    }
    return _typeLabel;
}

- (UIButton *)goEvaluationBtn {
    if (!_goEvaluationBtn) {
        _goEvaluationBtn = [[UIButton alloc] init];
        [_goEvaluationBtn setTitle:@"去评价 >" forState:UIControlStateNormal];
        [_goEvaluationBtn setTitleColor:[UIColor colorWithRed:0.80 green:0.64 blue:0.38 alpha:1.00] forState:UIControlStateNormal];
        _goEvaluationBtn.titleLabel.font = SYSTEMFONT(13);
        [_goEvaluationBtn addTarget:self action:@selector(goEvaluationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goEvaluationBtn;
}

#pragma mark - layout
- (void)layout{
    [self.goodsBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10/WIDTH_6_SCALE);
        make.bottom.right.mas_equalTo(-10/WIDTH_6_SCALE);
    }];
    [self.goEvaluationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(80/WIDTH_6_SCALE);
    }];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10/WIDTH_6_SCALE);
        make.bottom.mas_equalTo(-10/WIDTH_6_SCALE);
        make.width.mas_equalTo(70/WIDTH_6_SCALE);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10/WIDTH_6_SCALE);
        make.left.equalTo(self.goodsImageView.mas_right).with.offset(10/WIDTH_6_SCALE);
        make.right.equalTo(self.goEvaluationBtn.mas_left).with.offset(-10/WIDTH_6_SCALE);
        make.height.mas_equalTo(55/WIDTH_6_SCALE);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.goodsImageView.mas_right).with.offset(10/WIDTH_6_SCALE);
        make.right.equalTo(self.goEvaluationBtn.mas_left).with.offset(-10/WIDTH_6_SCALE);
        make.height.mas_equalTo(15/WIDTH_6_SCALE);
    }];
}

#pragma mark - event response
- (void)goEvaluationBtnAction {
    NSLog(@"去评价>>>>>");
    if (self.goEvaluationToCellBlock) {
        self.goEvaluationToCellBlock();
    }
}
@end
