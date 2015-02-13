//
//  PersonalProfileViewController.m
//  CarChat
//
//  Created by 赵佳 on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "PersonalProfileViewController.h"
#import <UzysAssetsPickerController.h>
#import "SetPersonalInfoParameter.h"
#import "UserModel+helper.h"
#import <UIImageView+WebCache.h>
#import "UIView+square2Round.h"
#import "UIView+frame.h"
#import "NSString+Helpers.h"

@interface PersonalProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) ALAsset * asset;

@property (nonatomic, strong) UIImageView * avatar;
@property (nonatomic, strong) UITextField * nickName;
@property (nonatomic, strong) UITextField * age;
@property (nonatomic, strong) UISegmentedControl * gender;
@property (nonatomic, strong) UITextField * city;

@end

@implementation PersonalProfileViewController

#pragma mark - Lifecycle

- (instancetype)initWithUserModel:(UserModel *)user
{
    if (self = [self init]) {
        [self setUser:user];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.avatar = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 36.f, 36.f)];
        [self.avatar makeRoundIfIsSquare];
        
        self.nickName = [[UITextField alloc]init];
        [self.nickName setTextAlignment:NSTextAlignmentRight];
        [self.nickName setFont:[UIFont boldSystemFontOfSize:13.f]];
        
        self.age = [[UITextField alloc]init];
        [self.age setTextAlignment:NSTextAlignmentRight];
        [self.age setFont:[UIFont boldSystemFontOfSize:13.f]];
        
        self.gender = [[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
        [self.gender setSelectedSegmentIndex:0];
        
        self.city = [[UITextField alloc]init];
        [self.city setTextAlignment:NSTextAlignmentRight];
        [self.city setFont:[UIFont boldSystemFontOfSize:13.f]];
    }
    return self;
}

- (void)dealloc
{
    [[CCNetworkManager defaultManager] removeObserver:self forApi:ApiSetPersonalInfo];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"编辑个人资料";
    [self setRightNavigationBarItem:@"保存" target:self andAction:@selector(save)];
    
    UITableView * t = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [t setDelegate:self];
    [t setDataSource:self];
    [t setTableFooterView:[UIView new]];
    [self.view addSubview:t];
    
    [[CCNetworkManager defaultManager] addObserver:(NSObject<CCNetworkResponse> *)self forApi:ApiSetPersonalInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCNetworkResponse
- (void)didGetResponseNotification:(ConcreteResponseObject *)response
{
    [self hideHud];
    
    if (response.error) {
        [self showTip:response.error.localizedDescription];
    }
    else {
        [self showTip:@"保存成功" whenDone: ^{
            if (self.navigationController.presentingViewController) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:13.f];
    switch (indexPath.row) {
        case 0:
        {
            // avatar
            cell.textLabel.text = @"头像";
            self.avatar.x = 250.f;
            self.avatar.y = 3.f;
            [cell.contentView addSubview:self.avatar];
        }
            break;
        case 1:
        {
            // nickname
            cell.textLabel.text = @"昵称";
            self.nickName.x = 60.f;
            self.nickName.y = 9.f;
            self.nickName.width = 226.f;
            self.nickName.height = 26.f;
            [cell.contentView addSubview:self.nickName];
        }
            break;
        case 2:
        {
            // age
            cell.textLabel.text = @"年龄";
            self.age.x = 60.f;
            self.age.y = 9.f;
            self.age.width = 226.f;
            self.age.height = 26.f;
            [cell.contentView addSubview:self.age];
        }
            break;
        case 3:
        {
            // gender
            cell.textLabel.text = @"性别";
            self.gender.x = 160.f;
            self.gender.y = 9.f;
            self.gender.width = 126.f;
            self.gender.height = 26.f;
            [cell.contentView addSubview:self.gender];
        }
            break;
        case 4:
        {
            // city
            cell.textLabel.text = @"城市";
            self.city.x = 60.f;
            self.city.y = 9.f;
            self.city.width = 226.f;
            self.city.height = 26.f;
            [cell.contentView addSubview:self.city];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            // avatar
            UzysAssetsPickerController * imagePicker = [[UzysAssetsPickerController alloc]init];
            imagePicker.assetsFilter = [ALAssetsFilter allPhotos];
            imagePicker.delegate = (id<UzysAssetsPickerControllerDelegate>)self;
            imagePicker.maximumNumberOfSelectionPhoto = 1;
            imagePicker.maximumNumberOfSelectionVideo = 0;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1:
        {
            // nickname
            [self.nickName becomeFirstResponder];
        }
            break;
        case 2:
        {
            // age
            [self.age becomeFirstResponder];
        }
            break;
        case 3:
        {
            // gender
            [self.gender becomeFirstResponder];
        }
            break;
        case 4:
        {
            // city
            [self.city becomeFirstResponder];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UzysAssetsPickerControllerDelegate
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    self.asset = assets[0];
    [self.avatar setImage:([UIImage imageWithCGImage:self.asset.aspectRatioThumbnail])];
}

- (void)UzysAssetsPickerControllerDidCancel:(UzysAssetsPickerController *)picker
{
}

- (void)UzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
{
    return;
}

#pragma mark - User Interaction
- (void)close
{
    [self dismissSelf];
}

- (void)save
{
    if ([self.nickName.text isBlank]
        || [self.age.text isBlank]
        || [self.city.text isBlank]
        || self.asset == nil) {
        [self showTip:@"请填写完整信息"];
        return;
    }
    
    [self showLoading:@"正在保存"];
    SetPersonalInfoParameter * par = (SetPersonalInfoParameter *)[ParameterFactory parameterWithApi:ApiSetPersonalInfo];
    par.nickName = self.nickName.text;
    par.age = self.age.text;
    par.city = self.city.text;
    par.gender = self.gender.selectedSegmentIndex + 1;
    par.avatar = UIImagePNGRepresentation(self.avatar.image);
    [[CCNetworkManager defaultManager] requestWithParameter:par];
}

#pragma mark - Internal Helper

- (void)setUser:(UserModel *)user
{
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    self.nickName.text = user.nickName;
    self.age.text = user.age;
    self.gender.selectedSegmentIndex = user.gender - 1;
    self.city.text = user.city;
}

@end
