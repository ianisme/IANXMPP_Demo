//
//  IANUtil.m
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "IANUtil.h"

@implementation IANUtil

// 从bundle中获取图片
+ (UIImage *)getImageName:(NSString *)imgName formBundle:(NSString *)bundleName isThreeFix:(BOOL)isFix imgType:(NSString *)imageType
{
    NSString *path = nil;
    if (isFix) {
        path = [[NSBundle mainBundle]
                pathForResource:[NSString stringWithFormat:@"%@/%@@%ldx", bundleName, imgName,(long)[self imagePixByDevice]] ofType:imageType];
    }else{
        path = [[NSBundle mainBundle]
                pathForResource:[NSString stringWithFormat:@"%@/%@", bundleName, imgName] ofType:imageType];
    }
    return [UIImage imageWithContentsOfFile:path];
}

/**
 *  图片倍数检查
 *
 *  @return 倍数
 */
+ (float)imagePixByDevice
{
    if (kDevice_Is_iPhone6Plus) {
        return 3.0;
    }else{
        return 2.0;
    }
}

@end
