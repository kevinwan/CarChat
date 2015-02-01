//
//  CommentModel+helper.m
//  CarChat
//
//  Created by Jia Zhao on 2/1/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "CommentModel+helper.h"
#import "UserModel.h"
#import "UserModel+helper.h"
#import <AVUser.h>

@implementation CommentModel (helper)

+ (instancetype)commentFromAVObject:(AVObject *)object
{
    CommentModel * model = [[CommentModel alloc]init];
    model.identifier = object.objectId;
    model.content = [object objectForKey:@"content"];
    model.user = [UserModel userFromAVUser:[object objectForKey:@"user"]];
    return model;
}

@end
