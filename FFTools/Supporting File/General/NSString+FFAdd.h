//
//  NSString+FFAdd.h
//  ZPFProject
//
//  Created by 周鹏飞 on 2018/12/28.
//  Copyright © 2018年 周鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FFAdd)
    
#pragma mark - Utilities
    
    /**
     去掉头部和尾部的空白字符（空格符和换行符等等）

     @return 整理之后的字符串
     */
    - (NSString *)stringByTrim;

@end

NS_ASSUME_NONNULL_END
