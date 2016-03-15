//
//  UserModel.h
//  IANXMPP_DEMO
//
//  Created by ian on 16/3/15.
//  Copyright © 2016年 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *serverAddress;

@end
