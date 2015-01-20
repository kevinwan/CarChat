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
@property (nonatomic, assign) ActivityCellStyle style;

@end

@implementation ActivitiesCollectionDelegator

- (instancetype)initWithActivities:(NSArray *)activities cellIdentifier:(NSString *)identifier andCellStyle:(ActivityCellStyle)style
{
    if (self = [super init]) {
        self.acitivities = activities;
        self.cellIdentifier = identifier;
        self.style = style;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.acitivities.count;
}

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
    
    self.configBlock(self.acitivities[indexPath.row], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock(self.acitivities[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
