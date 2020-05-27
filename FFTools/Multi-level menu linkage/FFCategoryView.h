//
//  FFCategoryView.h
//  bosheng
//
//  Created by zhou on 2019/12/14.
//  Copyright © 2019 bosheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///退出弹框
typedef void(^didExitAction)(void);
///确定弹框
typedef void(^didSubmitAction)(NSString *detail);

@interface FFCategoryView : UIView

/// 初始化
/// @param frame frame
/// @param data data
-(instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;
/**
 退出弹框
 */
@property (nonatomic, copy) didExitAction exitBlock;
/**
 确定
 */
@property (nonatomic, copy) didSubmitAction submitBlock;
@end

NS_ASSUME_NONNULL_END
