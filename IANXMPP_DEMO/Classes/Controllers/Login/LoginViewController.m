//
//  LoginViewController.m
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/14.
//  Copyright © 2016年 ian. All rights reserved.
//

#import "LoginViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "InputTextCell.h"
#import "UserModel.h"
#import "IANUtil.h"

static NSString * const kTableViewCellIdentifier = @"Input_Text_Cell";

@interface LoginViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UserModel *model;

@end

@implementation LoginViewController


#pragma mark - life style

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[UserModel alloc] init];
    [self creatTabelView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table view datasouse&&delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InputTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
    @weakify(self);
    if (indexPath.row == 0) {

        [cell configWithPlaceholder:@"账号" andValue:self.model.uid];
        cell.inputTextField.secureTextEntry = NO;
        cell.textValueChangedBlock = ^(NSString *valueStr){
            @strongify(self);
            self.model.uid = valueStr;
        };

    }else if (indexPath.row == 1){

        [cell configWithPlaceholder:@"密码" andValue:self.model.password];
        cell.inputTextField.secureTextEntry = YES;
        cell.textValueChangedBlock = ^(NSString *valueStr){
            @strongify(self);
            self.model.password = valueStr;
        };
        
    }else{
        [cell configWithPlaceholder:@"服务器地址" andValue:self.model.serverAddress];
        cell.inputTextField.secureTextEntry = NO;
        cell.textValueChangedBlock = ^(NSString *valueStr){
            @strongify(self);
            self.model.serverAddress = valueStr;
        };

    }
    return cell;
}


#pragma mark - private method

- (void)creatTabelView
{
    if (!_myTableView) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundView = self.bgBlurredView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[InputTextCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _myTableView = tableView;
        
        self.myTableView.tableHeaderView = [self creatTableHeaderView];
        self.myTableView.tableFooterView = [self creatTableFooterView];
    }
}

- (UIView *)creatTableHeaderView
{
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6){
        iconUserViewWidth = 90;
    }else{
        iconUserViewWidth = 75;
    }
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
    
    UIImageView *iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    iconUserView.layer.masksToBounds = YES;
    iconUserView.layer.cornerRadius = iconUserView.frame.size.width/2;
    iconUserView.layer.borderWidth = 2;
    iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [headerV addSubview:iconUserView];
    [iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.centerX.equalTo(headerV);
        make.centerY.equalTo(headerV).offset(30);
    }];
    [iconUserView setImage:[UIImage imageNamed:@"icon_user_default"]];
    return headerV;
}

- (UIView *)creatTableFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(18, 20, kScreen_Width-18*2, 45) target:self action:@selector(sendLogin:)];
    [footerV addSubview:_loginBtn];
    
    
    RAC(self, loginBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, model.uid), RACObserve(self, model.password), RACObserve(self, model.serverAddress)] reduce:^id(NSString *uid, NSString *password, NSString *serverAddress){

        return @((uid && uid.length > 0) && (password && password.length > 0) && (serverAddress && serverAddress.length > 0));

    }];
    
    return footerV;
}

- (UIImageView *)bgBlurredView{
    //背景图片
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *bgImage = [IANUtil getImageName:@"login_background_image" formBundle:@"OtherImage.bundle" isThreeFix:NO imgType:@"jpg"];

    
    CGSize bgImageSize = bgImage.size, bgViewSize = [bgView doubleSizeOfFrame];
//    if (bgImageSize.width > bgViewSize.width && bgImageSize.height > bgViewSize.height) {
//        bgImage = [bgImage scaleToSize:[bgView doubleSizeOfFrame] usingMode:NYXResizeModeAspectFill];
//    }
//    bgImage = [bgImage applyLightEffectAtFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    bgView.image = bgImage;
    //黑色遮罩
    UIColor *blackColor = [UIColor blackColor];
    [bgView addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.3].CGColor,
                                         (id)[blackColor colorWithAlphaComponent:0.3].CGColor]
                             locations:nil
                            startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 1.0)];
    return bgView;
}


#pragma mark - action method

- (void)sendLogin:(UIButton *)btn
{
    
}


@end
