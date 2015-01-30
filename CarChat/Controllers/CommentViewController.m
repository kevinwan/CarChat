//
//  CommentViewController.m
//  CarChat
//
//  Created by Develop on 15/1/21.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCollectionDelegator.h"
#import <UIImageView+WebCache.h>
#import "CommentModel.h"
#import "CommentCell.h"
#import "UserModel+helper.h"

static NSString * const commentIDentifier = @"commentCellIdentifier";

@interface CommentViewController ()

@property (nonatomic, copy) NSString * activityId;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic, strong) CommentCollectionDelegator *tableDelegator;
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
    self.tableDelegator = [[CommentCollectionDelegator alloc]initWithItems:self.comments andCellIdentifier:commentIDentifier];
    [self.tableDelegator setCellClass:[CommentCell class]];
    [self.tableDelegator setConfigBlock:^(CommentModel * item, CommentCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:item.user.avatarUrl]];
        cell.name.text = item.user.nickName;
        cell.genderIcon.image = item.user.genderImage;
        [cell.certifyIcon sd_setImageWithURL:[NSURL URLWithString:item.user.avatarUrl]];
        cell.contentLabel.text = item.content;
    }];
    [self.tableDelegator setSelectingBlock:^(CommentModel * item) {
        // TODO: 选中评论。。。
    }];
    [self.commentTable setDelegate:self.tableDelegator];
    [self.commentTable setDataSource:self.tableDelegator];
}

- (void)__createFackComments
{
    for (int i = 0; i < 10; i ++) {
        CommentModel *comment = [CommentModel new];
        comment.content = [NSString stringWithFormat:@"八心八箭，只卖%d%d%d,快点来抢哦，我是🐒总😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢😢",i,i,i];
        comment.user = [UserModel new];
        comment.user.nickName = [NSString stringWithFormat:@"嫖娼公知%d",i];
        comment.user.avatarUrl = @"http://a.hiphotos.baidu.com/image/pic/item/0dd7912397dda1444d5bd369b0b7d0a20df4869f.jpg";
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
