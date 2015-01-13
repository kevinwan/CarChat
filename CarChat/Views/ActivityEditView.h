//
//  ActivityEditView.h
//  CarChat
//
//  Created by 赵佳 on 15/1/14.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityEditView : UIView

+ (instancetype)viewWithActivity:(ActivityModel *)activity;

- (ActivityModel *)generateActivityAndStoreImageData:(NSData **)imageData;

@end
