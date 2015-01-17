//
//  SuggestedActivityViewController.m
//  CarChatLocal
//
//  Created by 赵佳 on 15/1/11.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "SuggestedActivityViewController.h"
#import "ActivitiesCollectionDelegator.h"
#import "ActivityModel.h"
#import <UIImageView+WebCache.h>

static NSString * const activityCellIdentifier = @"activityCellIdentifier";

@interface SuggestedActivityViewController ()
@property (weak, nonatomic) IBOutlet UITableView *suggestionTableView;
@property (nonatomic, strong) NSMutableArray * activities;
@property (nonatomic, strong) ActivitiesCollectionDelegator * tableDelegator;

@end

@implementation SuggestedActivityViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"推荐活动";
    
    [self __createActivitiesForDevelop];
    
    
    self.tableDelegator = [[ActivitiesCollectionDelegator alloc]initWithActivities:self.activities cellIdentifier:activityCellIdentifier];
    [self.tableDelegator setConfigBlock:^(ActivityModel * activity, SuggestActivityCell * cell) {
        [cell.poster sd_setImageWithURL:[NSURL URLWithString:activity.posterUrlStr]];
        cell.name.text = activity.name;
        cell.cost.text = [NSString stringWithFormat:@"费用:%@",activity.cost];
        cell.peopleCount.text = [NSString stringWithFormat:@"人数:%@",activity.amountOfPeople];
    }];
    __weak typeof(self) weakRef = self;
    [self.tableDelegator setSelectingBlock: ^(ActivityModel * activity) {
        __strong typeof(self) strongRef = weakRef;
        [ControllerCoordinator goNextFrom:strongRef
                                  whitTag:SuggestActivitiesSelectItem
                               andContext:activity];
    }];
    [self.suggestionTableView setDataSource:self.tableDelegator];
    [self.suggestionTableView setDelegate:self.tableDelegator];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self
                                            forApi:ApiGetSuggestActivities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lifecycle
- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self
                                               forApi:ApiGetSuggestActivities];
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    if (response.error) {
        // failed
    }
    else {
        // success
        NSString * api = response.api;
        if (api == ApiGetSuggestActivities) {
            // TODO:
        }
        else {
            
        }
    }
}

#pragma mark - Internal Helper

- (void)__createActivitiesForDevelop
{
    self.activities = [NSMutableArray array];
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
        activity.name = [NSString stringWithFormat:@"去钓鱼，上次我钓了%d条鱼，称了一下，%d斤！！！哎呀，还不够行数？",i,i*3];
        activity.destination = [NSString stringWithFormat:@"destination %d",i];
        activity.date = [NSString stringWithFormat:@"%@",[NSDate date]];
        activity.amountOfPeople = [NSString stringWithFormat:@"%d",i];
        activity.posterUrlStr = posters[i];
        activity.owner = [UserModel new];
        activity.owner.avatarUrlStr = @"http://b.hiphotos.baidu.com/image/pic/item/ca1349540923dd5427f5bd1dd309b3de9d8248c4.jpg";
        activity.owner.nickName = @"红烧肉";
        activity.owner.gender = (Gender)i%2;
        activity.cost = [NSString stringWithFormat:@"%d0$/person",i];
        [self.activities addObject:activity];
    }
}


@end
