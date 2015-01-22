//
//  CommentCollectionDelegator.m
//  CarChat
//
//  Created by 赵佳 on 15/1/22.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CommentCollectionDelegator.h"
#import "CommentCell.h"

@implementation CommentCollectionDelegator

#pragma mark - overwrite tableview datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CommentCell hegithForComment:[self itemAtIndexPath:indexPath]];
}

@end
