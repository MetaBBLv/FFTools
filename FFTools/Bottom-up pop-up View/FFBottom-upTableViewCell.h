//
//  FFBottom-upTableViewCell.h
//  FFTools
//
//  Created by zhou on 2019/7/18.
//  Copyright © 2019 MissZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///向cell发送消息
typedef void(^didGoEvaluationToCellAction)(void);

@interface FFBottom_upTableViewCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *model;
/**
 向cell发送消息
 */
@property (nonatomic, copy) didGoEvaluationToCellAction goEvaluationToCellBlock;
@end

NS_ASSUME_NONNULL_END
