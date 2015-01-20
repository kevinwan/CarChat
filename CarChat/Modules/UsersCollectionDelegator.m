//
//  UsersCollectionDelegator.m
//  CarChat
//
//  Created by Develop on 15/1/20.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UsersCollectionDelegator.h"

@interface UsersCollectionDelegator ()
@property (nonatomic, strong) NSArray * users;
@property (nonatomic, strong) NSString * cellIdentifier;
@end

@implementation UsersCollectionDelegator

- (instancetype)initWithUsers:(NSArray *)users cellIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.users = users;
        self.cellIdentifier = identifier;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UserCell alloc]initWithReuseIdentifier:self.cellIdentifier];
    }
    
    self.configBlock(self.users[indexPath.row], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock(self.users[indexPath.row]);
}

@end
