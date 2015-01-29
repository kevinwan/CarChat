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
    PayTypeEverybodyDutch = 1,
    PayTypeBoysDutch = 2,
    PayTypeSBTreat = 3,
};

typedef NS_OPTIONS(NSInteger, Relationship) {
    RelationshipFollowing = 1<<1,
    RelationshipFollower = 1<<2,
};

typedef NS_ENUM(NSInteger, CertifyStatus) {
    CertifyStatusUnverifyed = 1,
    CertifyStatusVerifying = 2,
    CertifyStatusVerifyed = 3
};

#endif
