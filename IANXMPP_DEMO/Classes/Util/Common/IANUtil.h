//
//  IANUtil.h
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IANUtil : NSObject

// 从bundle中获取图片
+ (UIImage *)getImageName:(NSString *)imgName formBundle:(NSString *)bundleName isThreeFix:(BOOL)isFix imgType:(NSString *)imageType;

@end
