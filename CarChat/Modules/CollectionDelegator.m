//
//  CollectionDelegator.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CollectionDelegator.h"

@interface CollectionDelegator ()

@end

@implementation CollectionDelegator

#pragma mark - Lifecycle
- (instancetype)initWithItems:(NSArray *)items andCellIdentifier:(NSString *)cellIdentifier
{
    if (self = [super init]) {
        _items = items;
        _cellIdentifier = cellIdentifier;
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [(UITableViewCell *)[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    
    self.configBlock(self.items[indexPath.row], cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectingBlock(self.items[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Property Overwrite
- (Class)cellClass
{
    if (_cellClass == Nil) {
        return [UITableViewCell class];
    }
    return _cellClass;
}

@end
