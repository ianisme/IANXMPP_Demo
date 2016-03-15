//
//  UIView+Common.h
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

- (CGSize)doubleSizeOfFrame;

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint;

@end
