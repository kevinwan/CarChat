//
//  SubmitCertificationProfileParameter.h
//  CarChat
//
//  Created by Jia Zhao on 2/8/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ABCParameter.h"

@interface SubmitCertificationProfileParameter : ABCParameter

@property (nonatomic, copy) NSString * plateNO;
@property (nonatomic, strong) UIImage * licenseImage;

@end
