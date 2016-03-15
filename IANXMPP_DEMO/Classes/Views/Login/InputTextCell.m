//
//  InputTextCell.m
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "InputTextCell.h"

static CGFloat const kInput_OnlyText_Cell_LeftPading = 18.0;

@implementation InputTextCell
{
    UIView *_lineView;
}

#pragma mark - life style

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)configWithPlaceholder:(NSString *)phStr andValue:(NSString *)valueStr
{
    _inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5]}];
    _inputTextField.text = valueStr;
}


#pragma mark - private method

- (void)creatView
{
    self.backgroundColor = [UIColor clearColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.textColor = [UIColor whiteColor];
    [self.contentView addSubview:textField];
    _inputTextField = textField;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_user_delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    _clearBtn = btn;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
    [self.contentView addSubview:lineView];
    _lineView = lineView;
    
    [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, kInput_OnlyText_Cell_LeftPading, 0, kInput_OnlyText_Cell_LeftPading));
    }];
    
    [_clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(self.contentView).with.offset(-kInput_OnlyText_Cell_LeftPading);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.right.equalTo(_inputTextField);
        make.bottom.equalTo(self.contentView);
    }];
    
    @weakify(self);
    [_inputTextField.rac_textSignal subscribeNext:^(NSString *x) {
        @strongify(self);
        if (x && x.length > 0) {
            self.clearBtn.hidden = NO;
        } else {
            self.clearBtn.hidden = YES;
        }
        if(self.textValueChangedBlock){
            self.textValueChangedBlock(x);
        }
    }];
}


#pragma mark - action method

- (void)clearBtnClick:(UIButton *)btn
{
    self.inputTextField.text = nil;
}


@end
