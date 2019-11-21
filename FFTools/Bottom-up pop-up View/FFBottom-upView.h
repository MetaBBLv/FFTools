//
//  FFBottom-upView.h
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///退出底部弹框
typedef void(^didExitAction)(void);
///弹框内cell点击
typedef void(^didCellAction)(NSInteger index);
///弹框内cell内button点击：此demo为去评价
typedef void(^didGoEvaluationAction)(NSInteger index);

@interface FFBottom_upView : UIView

/**
 弹出视图初始化

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


/**
 退出底部弹框
 */
@property (nonatomic, copy) didExitAction exitBlock;

/**
 弹框内cell 点击
 */
@property (nonatomic, copy) didCellAction cellBlock;

/**
 弹框内cell内button点击：此demo为去评价
 */
@property (nonatomic, copy) didGoEvaluationAction goEvaluationBlock;
@end

NS_ASSUME_NONNULL_END
