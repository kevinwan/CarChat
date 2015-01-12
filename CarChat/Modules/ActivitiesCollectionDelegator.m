//
//  AcitivitiesTableDelegator.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "ActivitiesCollectionDelegator.h"

@interface ActivitiesCollectionDelegator ()

@property (nonatomic, strong) NSArray * acitivities;
@property (nonatomic, assign) NSString * cellIdentifier;

@end

@implementation ActivitiesCollectionDelegator

- (instancetype)initWithActivities:(NSArray *)activities cellIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.acitivities = activities;
        self.cellIdentifier = identifier;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.acitivities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
    }
    
    self.configBlock(self.acitivities[indexPath.row], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock(self.acitivities[indexPath.row]);
}

@end
