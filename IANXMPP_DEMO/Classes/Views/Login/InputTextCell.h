//
//  InputTextCell.h
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TextValueChangedBlock)(NSString *);

@interface InputTextCell : UITableViewCell

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, copy) TextValueChangedBlock textValueChangedBlock;

- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr;


@end
