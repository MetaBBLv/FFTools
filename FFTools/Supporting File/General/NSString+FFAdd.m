//
//  NSString+FFAdd.m
//  ZPFProject
//
//  Created by 周鹏飞 on 2018/12/28.
//  Copyright © 2018年 周鹏飞. All rights reserved.
//

#import "NSString+FFAdd.h"

@implementation NSString (FFAdd)

    - (NSString *)stringByTrim{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        return [self stringByTrimmingCharactersInSet:set];
    }
    
@end
