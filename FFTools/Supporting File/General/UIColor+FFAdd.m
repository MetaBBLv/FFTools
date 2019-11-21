//
//  UIColor+FFAdd.m
//  ZPFProject
//
//  Created by 周鹏飞 on 2018/12/28.
//  Copyright © 2018年 周鹏飞. All rights reserved.
//

#import "UIColor+FFAdd.h"
#import "NSString+FFAdd.h"
#import "FFKitMacro.h"

@implementation UIColor (FFAdd)


- (void)zpf:(NSString *)str{
    NSUInteger a = 111;
    NSLog(@"%lu",(unsigned long)a);
}
    static inline NSUInteger hexStringToInt(NSString *str) {
        uint32_t result = 0;
        sscanf([str UTF8String], "%X", &result);
        return result;
    }
    
    static BOOL hexStringToRGBA(NSString *str,
                                CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a){
        str = [[str stringByTrim] uppercaseString];
        if ([str hasPrefix:@"#"]) {
            str = [str substringFromIndex:1];
        } else if ([str hasPrefix:@"0X"]) {
            str = [str substringFromIndex:2];
        }
        
        NSUInteger length = [str length];
        //         RGB            RGBA          RRGGBB       RRGGBBAA
        if (length != 3 && length != 4 && length != 6 && length !=8) {
            return NO;
        }
        //RGB,RGBA,RRGGBB,RRGGBBAA
        if (length < 5) {
            *r = hexStringToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
            *g = hexStringToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
            *b = hexStringToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
            if (length == 4) {
                *a = hexStringToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
            } else {
                *a = 1;
            }
        } else {
            *r = hexStringToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
            *g = hexStringToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
            *b = hexStringToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
            if (length == 8) {
                *a = hexStringToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
            } else {
                *a = 1;
            }
        }
        return YES;
    }
    
    + (UIColor *)colorWithHexString:(NSString *)hexStr{
        CGFloat r, g, b, a;
        if (hexStringToRGBA(hexStr, &r, &g, &b, &a)) {
            return [UIColor colorWithRed:r green:g blue:b alpha:a];
        }
        return nil;
    }

@end
