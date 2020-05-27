//
//  FFCategoryCollectionViewCell.m
//  bosheng
//
//  Created by zhou on 2019/12/13.
//  Copyright © 2019 bosheng. All rights reserved.
//

#import "FFCategoryCollectionViewCell.h"

@interface FFCategoryCollectionViewCell ()
@property (nonatomic, strong) UILabel *itemLabel;
@end

@implementation FFCategoryCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.itemLabel = [[UILabel alloc] init];
        self.itemLabel.textColor = [UIColor blackColor];
        self.itemLabel.font = [UIFont systemFontOfSize:12];
        self.itemLabel.layer.cornerRadius = 13/WIDTH_6_SCALE;
        self.itemLabel.layer.masksToBounds = YES;
        self.itemLabel.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.itemLabel];
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(75/WIDTH_6_SCALE, 25/WIDTH_6_SCALE));
        }];
    }
    return self;
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    self.itemLabel.text = model[@"typeName"];
    if ([model[@"select"] isEqualToString:@"1"]) {
        self.itemLabel.textColor = [UIColor colorWithHexString:@"d13931"];
        self.itemLabel.font = [UIFont systemFontOfSize:12];
        self.itemLabel.layer.cornerRadius = 13/WIDTH_6_SCALE;
        self.itemLabel.layer.masksToBounds = YES;
        self.itemLabel.layer.borderColor = [UIColor colorWithHexString:@"d13931"].CGColor;
        self.itemLabel.layer.borderWidth = 1;
        self.itemLabel.backgroundColor = [UIColor colorWithHexString:@"f7e8e8"];
    }
    else
    {
        self.itemLabel.textColor = [UIColor blackColor];
        self.itemLabel.font = [UIFont systemFontOfSize:12];
        self.itemLabel.layer.cornerRadius = 13/WIDTH_6_SCALE;
        self.itemLabel.layer.masksToBounds = YES;
        self.itemLabel.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
        self.itemLabel.layer.borderWidth = 1;
        self.itemLabel.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
}

@end
