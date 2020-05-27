//
//  UtilsMacros.h
//  ZPFHimalayan
//
//  Created by zhou on 2018/11/23.
//  Copyright © 2018 MissZhou. All rights reserved.
//

//全局工具类宏定义
#ifndef UtilsMacros_h
#define UtilsMacros_h

//获取系统对象
#define kApplication [UIApplication sharedApplication]
#define kAppWindow   [UIApplication sharedApplication].delegate.window
#define kAppDelegate [UIAppDelegate sharedAppDelegate]

//屏幕宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

/**iphone X 导航栏 */
#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
/**iphone X tabbar底部 */
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)
/**iphone X 顶部状态栏高度 */
#define SafeAreaTopStateHeight (SCREEN_HEIGHT == 812.0 ? 44 : 20)

#define SafeAreaBottomHeighTtabbar ([[UIApplication sharedApplication] statusBarFrame].size.height == 20 ? 49 : 83)

//5S宽高比例
#define WIDTH_5S_SCALE 320.0 * [UIScreen mainScreen].bounds.size.width
#define HEIGHT_5S_SCALE 568.0 * [UIScreen mainScreen].bounds.size.height

//6宽高比例
#define WIDTH_6_SCALE 375.0 * [UIScreen mainScreen].bounds.size.width
#define HEIGHT_6_SCALE 667.0 * [UIScreen mainScreen].bounds.size.width

//强弱引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//view 加圆角和边框
#define viewAddBorderAndRadius(View,Radius,Width,Color)\
\
[View.layer.cornerRadius:(Radius)];\
[View.layer.masksBounds:Yes];\
[View.layer.setBorderWidth:Width];\
[View.layer.setBorderColor:[UIColor CGColor]]

//view 加圆角
#define ViewAddRadius(View,Radius)\
\
[View.layer.cornerRadius:(Radius)];\
[View.layer.masksBounds:YES]

//IOS版本判断
#define IOSAVAILABLEEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] > 0)
//当前系统版本
#define currentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define currentLanguage [[NSLocale preferrdLanguages] objectAtIndex:0]

//DEBUG模式下打印日志，当前行
#ifdef DEBUG
#define DLog(fmt,...) NSLog((@"%s [line %d] ",fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format, ##__VA_ARGS__]

//字体
#define FONTANDNAME(NAME,FONTSIZE) [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define FONTANDBOLD(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE) [UIFont systemFontOfSize:FONTSIZE]

//定义image对象
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString Class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArr(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count] > 0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime NSLog(@"Time: %f",CFAbsoluteTimeGetCurrent() - start)

//发送通知
#define kPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken,^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* UtilsMacros_h */
