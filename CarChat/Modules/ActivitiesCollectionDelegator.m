//
//  AcitivitiesTableDelegator.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivitiesCollectionDelegator.h"

@interface ActivitiesCollectionDelegator ()

@end

@implementation ActivitiesCollectionDelegator

#pragma mark - Super Method Overwrite
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.style == ActivityCellStyleSuggest ? ActivityCellStyleSuggestHeight : ActivityCellStyleUserCreatedHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[ActivityCell alloc]initWithActivityCellStyle:self.style reuseIdentifier:self.cellIdentifier];
    }
    
    self.configBlock(self.items[indexPath.row], cell);
    
    return cell;
}

@end
