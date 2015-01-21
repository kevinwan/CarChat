//
//  CommentModel.h
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, strong) UserModel * user;
@end
