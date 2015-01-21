//
//  UsersCollectionDelegator.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UsersCollectionDelegator.h"
#import "UserCell.h"

@implementation UsersCollectionDelegator

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UserCellHeight;
}

@end
