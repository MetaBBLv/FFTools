//
//  FFBottom-upView.h
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^didExitAction)(void);

@interface FFBottom_upView : UIView

/**
 弹出c视图初始化

 @param frame frame
 @param title 标题
 @param description 描述
 @param dataArray 数据
 @return FF
 */
- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                  Description:(NSString *)description
                    DataArray:(NSArray *)dataArray;

@property (nonatomic, copy) didExitAction exitBlock;
@end

NS_ASSUME_NONNULL_END
