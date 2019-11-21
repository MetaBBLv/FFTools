//
//  FFMiddle-upView.h
//  FFTools
//
//  Created by zhou on 2019/11/21.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///退出弹框
typedef void(^didExitAction)(void);
///退出弹框
typedef void(^didSubmitAction)(void);

@interface FFMiddle_upView : UIView

/// 弹出试图初始化
/// @param frame frame
/// @param title 标题
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title;

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
