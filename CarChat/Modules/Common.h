//
//  Common.h
//  CarChat
//
//  Created by Develop on 15/1/16.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#ifndef CarChat_Common_h
#define CarChat_Common_h


typedef NS_ENUM(NSInteger, Gender) {
    GenderUnknow = 0,
    GenderMale = 1,
    GenderFemale = 2
};

typedef NS_ENUM(NSInteger, PayType) {
    PayTypeSBTreat = 1,
    PayTypeEverybodyDutch = 2,
    PayTypeBoysDutch = 3
};

typedef NS_OPTIONS(NSInteger, Relationship) {
    RelationshipFollowing = 1<<1,
    RelationshipFollower = 1<<2,
};

#endif
