//
//  InviteTableDelegator.m
//  CarChat
//
//  Created by 赵佳 on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "InviteTableDelegator.h"

@interface InviteTableDelegator () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) NSString * cellIdentifier;

@end

@implementation InviteTableDelegator

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.items = items;
        self.cellIdentifier = identifier;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    
    self.configBlock(self.items[indexPath.row], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock(self.items[indexPath.row]);
}

@end
