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
#import "UIView+frame.h"
#import "NSString+Helpers.h"
#import "ReplyActivityParameter.h"

static NSString * const commentIDentifier = @"commentCellIdentifier";
static CGFloat const kInputViewGrowHeight = 50.f;

@interface CommentViewController ()

@property (nonatomic, copy) NSString * activityId; // must not nil

@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (nonatomic, strong) CommentCollectionDelegator *tableDelegator;
@property (nonatomic, strong) NSMutableArray *comments;


@property (weak, nonatomic) IBOutlet UIView *inputBGView;
@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

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
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiReplyActivity];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiGetCommentsInActivity];
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiReplyActivity];
    
    [self requestComments];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    if (![response.parameter.uniqueId isEqualToString:self.description]) {
        return;
    }
    
    [self hideHud];
    
    if (response.error) {
        // fail
        [self showTip:response.error.localizedDescription];
    }
    else {
        if (response.parameter.api == ApiGetCommentsInActivity) {
            [self.comments addObjectsFromArray:response.object];
            [self.commentTable reloadData];
        }
        else if (response.parameter.api == ApiReplyActivity) {
            [self showTip:@"评论成功"];
            
            
            CommentModel *c = [CommentModel new];
            c.content = self.inputView.text;
            c.user = [UserModel currentUser];
            [self.commentTable beginUpdates];
            [self.commentTable insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.comments.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.comments addObject:c];
            [self.commentTable endUpdates];
            
            
            self.inputView.text = nil;
            [self.inputView resignFirstResponder];
        }
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.2f animations:^{
        self.inputBGView.y -= kInputViewGrowHeight;
        self.inputBGView.height += kInputViewGrowHeight;
        self.commentTable.height -= kInputViewGrowHeight;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.2f animations:^{
        self.inputBGView.y += kInputViewGrowHeight;
        self.inputBGView.height -= kInputViewGrowHeight;
        self.commentTable.height += kInputViewGrowHeight;
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [ControllerCoordinator goNextFrom:self whitTag:ShowLoginFromSomeWhereTag andContext:nil];
}

#pragma mark - Internal Helps
- (void)setupTableDelegator
{
    self.tableDelegator = [[CommentCollectionDelegator alloc]initWithItems:self.comments
                                                         andCellIdentifier:commentIDentifier];
    [self.tableDelegator setCellClass:[CommentCell class]];
    [self.tableDelegator setConfigBlock:^(CommentModel * item, CommentCell * cell) {
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:item.user.avatarUrl]];
        cell.name.text = item.user.nickName;
        cell.genderIcon.image = item.user.genderImage;
        [cell.certifyIcon setImage:item.user.certifyStatusImage];
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
    p.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:p];
}

#pragma mark - User Interactions
- (IBAction)leaveACommetn:(id)sender {
    if ([self.inputView.text isBlank]) {
        return;
    }
    
    if ([UserModel currentUser] == nil) {
        // 没有登录
        UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"您还没有登录" message:@"请登录后再评论" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [a show];
        return;
    }
    
    [self showLoading:@""];
    ReplyActivityParameter * r = (ReplyActivityParameter *)[ParameterFactory parameterWithApi:ApiReplyActivity];
    r.content = self.inputView.text;
    r.activityIdentifier = self.activityId;
    r.uniqueId = self.description;
    [[CCNetworkManager defaultManager] requestWithParameter:r];
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

- (void)setInputViewHidden:(BOOL)hidden
{
    [self.inputBGView setHidden:hidden];
    if (hidden) {
        self.commentTable.height = self.inputBGView.y + self.inputBGView.height;
    }
    else {
        self.commentTable.height = self.inputBGView.y;
    }
}

@end
