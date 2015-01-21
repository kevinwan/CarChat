//
//  CommentViewController.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CommentViewController.h"
#import "CollectionDelegator.h"
#import <UIImageView+WebCache.h>
#import "CommentModel.h"

static NSString * const commentIDentifier = @"commentCellIdentifier";

@interface CommentViewController ()

@property (nonatomic, copy) NSString * activityId;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic, strong) CollectionDelegator *tableDelegator;
@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation CommentViewController

#pragma mark - Lifecycle
- (instancetype)initWithActivityId:(NSString *)activityId
{
    if (self = [super init]) {
        self.activityId = activityId;
        self.comments = [NSMutableArray array];
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableDelegator];
    [self __createFackComments];
}

#pragma mark - User Interaction
- (IBAction)comment:(id)sender {
    LOG_EXPR(@"show comment");
}

#pragma mark - Internal Helps
- (void)setupTableDelegator
{
    self.tableDelegator = [[CollectionDelegator alloc]initWithItems:self.comments andCellIdentifier:commentIDentifier];
    [self.tableDelegator setConfigBlock:^(CommentModel * item, UITableViewCell * cell) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.user.avatar]];
        cell.textLabel.text = item.content;
    }];
    [self.tableDelegator setSelectingBlock:^(id item) {
        // TODO: 选中评论。。。
    }];
    [self.commentTable setDelegate:self.tableDelegator];
    [self.commentTable setDataSource:self.tableDelegator];
}

- (void)__createFackComments
{
    for (int i = 0; i < 10; i ++) {
        CommentModel *comment = [CommentModel new];
        comment.content = [NSString stringWithFormat:@"八心八箭，只卖%d%d%d",i,i,i];
        comment.user = [UserModel new];
        comment.user.nickName = [NSString stringWithFormat:@"嫖娼公知%d",i];
        comment.user.avatar = @"http://a.hiphotos.baidu.com/image/pic/item/0dd7912397dda1444d5bd369b0b7d0a20df4869f.jpg";
        comment.user.gender = GenderMale;
        [self.comments addObject:comment];
    }
}

#pragma mark - Public APIs
- (void)setListHeaderView:(UIView *)headerView
{
    [self.commentTable setTableHeaderView:headerView];
}

@end
