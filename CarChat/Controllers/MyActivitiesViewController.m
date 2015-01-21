//
//  MyActivitiesViewController.m
//  CarChat
//
//  Created by Develop on 15/1/15.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "MyActivitiesViewController.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityCell.h"
#import "ActivityModel.h"
#import <UIImageView+WebCache.h>

static NSString * const activityCeleIdentifier = @"myActivityIdentifier";

@interface MyActivitiesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *activityTable;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;
@property (nonatomic, strong) NSMutableArray * activityItems;

@end

@implementation MyActivitiesViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的活动";
    
    self.activityItems = [NSMutableArray array];
    [self __createTestData];
    [self setupTableViewDelegator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Internal Helper
- (void)setupTableViewDelegator
{
    self.tableDelegator = [[ActivitiesCollectionDelegator alloc]initWithItems:self.activityItems andCellIdentifier:activityCeleIdentifier];
    [self.tableDelegator setCellClass:[ActivityCell class]];
    [self.tableDelegator setStyle:ActivityCellStyleUserCreated];
    [self.tableDelegator setConfigBlock:^(ActivityModel * activity, ActivityCell * cell) {
        [cell.poster sd_setImageWithURL:[NSURL URLWithString:activity.poster]];
        cell.name.text = activity.name;
        cell.cost.text = [NSString stringWithFormat:@"费用:%@",activity.cost];
        cell.toplimit.text = [NSString stringWithFormat:@"人数:%@",activity.toplimit];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatar]];
        cell.nickName.text = activity.owner.nickName;
        cell.genderIcon.image = [activity.owner genderImage];
        [cell.certifyIcon sd_setImageWithURL:[NSURL URLWithString:activity.owner.avatar]];
    }];
    __weak typeof(self) weakRef = self;
    [self.tableDelegator setSelectingBlock:^(ActivityModel *activity) {
        [ControllerCoordinator goNextFrom:weakRef whitTag:MyActivitiesCellTag andContext:activity];
    }];
    
    [self.activityTable setDelegate:self.tableDelegator];
    [self.activityTable setDataSource:self.tableDelegator];
}

- (void)__createTestData
{
    NSArray * posters = @[@"http://pic3.bbzhi.com/youxibizhi/jipinfeiche114/jingxuan_yxjx_214782_18.jpg",
                          @"http://f.hiphotos.baidu.com/zhidao/pic/item/c8177f3e6709c93d0d1704f39d3df8dcd00054c8.jpg",
                          @"http://pic3.bbzhi.com/youxibizhi/zhengdangfangwei2/jingxuan_yxjx_277739_18.jpg",
                          @"http://pic1a.nipic.com/2008-10-23/2008102323598475_2.jpg",
                          @"http://img2.niutuku.com/desk/1208/1524/ntk-1524-42510.jpg",
                          @"http://f.hiphotos.baidu.com/zhidao/pic/item/c8177f3e6709c93d0d1704f39d3df8dcd00054c8.jpg",
                          @"http://pic3.bbzhi.com/youxibizhi/zhengdangfangwei2/jingxuan_yxjx_277739_18.jpg",
                          @"http://pic1a.nipic.com/2008-10-23/2008102323598475_2.jpg",
                          @"http://img2.niutuku.com/desk/1208/1524/ntk-1524-42510.jpg",
                          @"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1102/16/c1/6758855_6758855_1297853768203.jpg"];
    for (int i = 0; i < 10; i++) {
        ActivityModel * activity = [ActivityModel new];
        activity.name = [NSString stringWithFormat:@"叽叽喳喳%d,%d喳喳唧唧",i,i*3];
        activity.destination = [NSString stringWithFormat:@"destination %d",i];
        activity.date = [NSString stringWithFormat:@"%@",[NSDate date]];
        activity.toplimit = [NSString stringWithFormat:@"%d",i];
        activity.poster = posters[i];
        activity.owner = [UserModel new];
        activity.owner.avatar = @"http://b.hiphotos.baidu.com/image/pic/item/ca1349540923dd5427f5bd1dd309b3de9d8248c4.jpg";
        activity.owner.nickName = @"红烧带鱼";
        activity.owner.gender = (Gender)i%2;
        activity.payType = PayTypeSBTreat;
        activity.cost = [NSString stringWithFormat:@"%d0$/person",i];
        [self.activityItems addObject:activity];
    }
}

@end
