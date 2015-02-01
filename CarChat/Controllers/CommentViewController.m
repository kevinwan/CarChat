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
#import "GetCommentsInActivityParameter.h"

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

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiGetCommentsInActivity];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetCommentsInActivity];
    
    [self requestComments];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error) {
        // fail
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self.comments addObjectsFromArray:response.object];
        [self.commentTable reloadData];
    }
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

- (void)requestComments
{
    GetCommentsInActivityParameter * p = (GetCommentsInActivityParameter *)[ParameterFactory parameterWithApi:ApiGetCommentsInActivity];
    p.activityIdentifier = self.activityId;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

#pragma mark - Public APIs
- (void)setListHeaderView:(UIView *)headerView
{
    [self.commentTable setTableHeaderView:headerView];
}

- (void)setListFooterView:(UIView *)footerView
{
    [self.commentTable setTableFooterView:footerView];
}

@end
