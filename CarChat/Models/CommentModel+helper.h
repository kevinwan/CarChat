//
//  CommentModel+helper.h
//  CarChat
//
//  Created by Jia Zhao on 2/1/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "CommentModel.h"
#import <AVObject.h>

@interface CommentModel (helper)

+ (instancetype)commentFromAVObject:(AVObject *)object;

@end
