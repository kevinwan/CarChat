//
//  CCNetworkResponse.h
//  CarChat
//
//  Created by 赵佳 on 15/1/12.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCNetworkResponse <NSObject>

- (void)didGetResponseNotification:(NSNotification *)response;

@end
