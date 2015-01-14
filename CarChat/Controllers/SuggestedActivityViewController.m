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
    [self.tableDelegator setConfigBlock:^(ActivityModel * activity, UITableViewCell * cell) {
        cell.textLabel.text = [NSString stringWithFormat:@"suggestion %@",activity.description];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"date %@",[NSDate date]];
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
            // TODO
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
                          @"http://bizhi.zhuoku.com/2011/02/19/1080p/1080p80.jpg",
                          @"http://f.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b041066b180025aafa40f0680.jpg",
                          @"http://d.hiphotos.baidu.com/zhidao/pic/item/cdbf6c81800a19d8d7698e0131fa828ba61e464f.jpg",@"http://pic3.bbzhi.com/youxibizhi/jipinfeiche114/jingxuan_yxjx_214782_18.jpg",
                          @"http://f.hiphotos.baidu.com/zhidao/pic/item/c8177f3e6709c93d0d1704f39d3df8dcd00054c8.jpg",
                          @"http://bizhi.zhuoku.com/2011/02/19/1080p/1080p80.jpg",
                          @"http://f.hiphotos.baidu.com/zhidao/pic/item/d833c895d143ad4b041066b180025aafa40f0680.jpg",
                          @"http://d.hiphotos.baidu.com/zhidao/pic/item/cdbf6c81800a19d8d7698e0131fa828ba61e464f.jpg"];
    for (int i = 0; i < 10; i++) {
        ActivityModel * activity = [ActivityModel new];
        activity.name = [NSString stringWithFormat:@"name %d",i];
        activity.destination = [NSString stringWithFormat:@"destination %d",i];
        activity.date = [NSString stringWithFormat:@"%@",[NSDate date]];
        activity.amountOfPeople = [NSString stringWithFormat:@"%d",i];
        activity.posterUrlStr = posters[i];
        activity.starterAvtar = @"http://b.hiphotos.baidu.com/image/pic/item/ca1349540923dd5427f5bd1dd309b3de9d8248c4.jpg";
        activity.starterName = @"红烧肉";
        activity.starterGender = 1;
        activity.cost = [NSString stringWithFormat:@"%d0$/person",i];
        [self.activities addObject:activity];
    }
}


@end
