//
//  UIView+Common.m
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)


- (CGSize)doubleSizeOfFrame
{
    CGSize size = self.frame.size;
    return CGSizeMake(size.width*2, size.height*2);
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}

@end
