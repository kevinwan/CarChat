//
//  MyProfileCard.m
//  CarChat
//
//  Created by Develop on 15/1/19.
//  Copyright (c) 2015年 GongPingJia. All rights reserved.
//

#import "UserProfileCard.h"
#import "UIView+square2Round.h"
#import <UIImageView+WebCache.h>
#import "Common.h"

@interface UserProfileCard ()
@property (strong, nonatomic)  UIImageView *avatarView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UIImageView *genderView;
@property (strong, nonatomic)  UIImageView *certifyView;
@property (strong, nonatomic)  UIButton *activityNumButton;
@property (strong, nonatomic)  UIButton *followingNumButton;
@property (strong, nonatomic)  UIButton *followerNumButton;
@property (strong, nonatomic) UIButton *relationshipButton;

@end

@implementation UserProfileCard

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(10.f, 10.f, 50.f, 50.f)];
        [self addSubview:self.avatarView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(68.f, 10.f, 244.f, 20.f)];
        [self.nameLabel setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:self.nameLabel];
        
        self.genderView = [[UIImageView alloc]initWithFrame:CGRectMake(68.f, 38.f, 20.f, 20.f)];
        [self addSubview:self.genderView];
        
        self.certifyView = [[UIImageView alloc]initWithFrame:CGRectMake(96.f, 38.f, 20.f, 20.f)];
        [self addSubview:self.certifyView];
        
        UILabel * staticLB = [[UILabel alloc]initWithFrame:CGRectMake(32.f, 105.f, 42.f, 20.f)];
        [staticLB setText:@"活动"];
        [staticLB setFont:[UIFont systemFontOfSize:12.f]];
        [staticLB setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:staticLB];
        
        staticLB = [[UILabel alloc]initWithFrame:CGRectMake(127.f, 105.f, 67.f, 20.f)];
        [staticLB setText:@"关注"];
        [staticLB setFont:[UIFont systemFontOfSize:12.f]];
        [staticLB setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:staticLB];
        
        staticLB = [[UILabel alloc]initWithFrame:CGRectMake(235.f, 105.f, 64.f, 20.f)];
        [staticLB setText:@"听众"];
        [staticLB setFont:[UIFont systemFontOfSize:12.f]];
        [staticLB setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:staticLB];
        
        staticLB = [[UILabel alloc]initWithFrame:CGRectMake(106.f, 75.f, 1.f, 50.f)];
        [staticLB setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:staticLB];
        
        staticLB = [[UILabel alloc]initWithFrame:CGRectMake(213.f, 75.f, 1.f, 50.f)];
        [staticLB setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:staticLB];
        
        self.activityNumButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.activityNumButton setFrame:CGRectMake(3.f, 74.f, 100.f, 51.f)];
        [self.activityNumButton setTitle:@"0" forState:UIControlStateNormal];
        [self.activityNumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
        [self.activityNumButton setTitleEdgeInsets:UIEdgeInsetsMake(-10.f, 0, 0, 0)];
        [self.activityNumButton addTarget:self action:@selector(touchActivity:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.activityNumButton];
        
        self.followingNumButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.followingNumButton setFrame:CGRectMake(110.f, 74.f, 100.f, 51.f)];
        [self.followingNumButton setTitle:@"0" forState:UIControlStateNormal];
        [self.followingNumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
        [self.followingNumButton setTitleEdgeInsets:UIEdgeInsetsMake(-10.f, 0, 0, 0)];
        [self.followingNumButton addTarget:self action:@selector(touchFollowing:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.followingNumButton];
        
        self.followerNumButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.followerNumButton setFrame:CGRectMake(217.f, 74.f, 100.f, 51.f)];
        [self.followerNumButton setTitle:@"0" forState:UIControlStateNormal];
        [self.followerNumButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.f]];
        [self.followerNumButton setTitleEdgeInsets:UIEdgeInsetsMake(-10.f, 0, 0, 0)];
        [self.followerNumButton addTarget:self action:@selector(touchFollower:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.followerNumButton];
    }
    
    return self;
}

+ (instancetype)view
{
    return [[[self class]alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 136.f)];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.avatarView makeRoundIfIsSquare];
    [self.genderView makeRoundIfIsSquare];
    [self.certifyView makeRoundIfIsSquare];
}

#pragma mark - Public Api
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)layoutWithUser:(UserModel *)user
{
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    self.nameLabel.text = user.nickName;
    self.genderView.image = [user genderImage];
    [self.certifyView setBackgroundColor:[UIColor yellowColor]];
    
    [self.activityNumButton setTitle:user.countOfActvity forState:UIControlStateNormal];
    [self.followingNumButton setTitle:user.countOfFollowing forState:UIControlStateNormal];
    [self.followerNumButton setTitle:user.countOfFollower forState:UIControlStateNormal];
//    [self configButtonWithRelationship:user.relationship];
    // TODO: replace the logic
    [self configButtonWithRelationship:(size_t)self%0xf * 2];
}

#pragma mark - User Interaction
- (void)configButtonWithRelationship:(Relationship)relationship
{
    if (relationship == 0) {
        return;
    }
    
    if (!self.relationshipButton) {
        self.relationshipButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.relationshipButton setFrame:CGRectMake(126.f, 38.f, 46.f, 20.f)];
        [self.relationshipButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
        [self.relationshipButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [self.relationshipButton addTarget:self action:@selector(touchRelationshipButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.relationshipButton];
    }
    
    if (relationship & RelationshipFollowing) {
        [self.relationshipButton setBackgroundColor:[UIColor greenColor]];
        [self.relationshipButton setTitle:@"已关注" forState:UIControlStateNormal];
    }
    else {
        [self.relationshipButton setBackgroundColor:[UIColor yellowColor]];
        [self.relationshipButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)touchActivity:(id)sender {
    if (self.activityTouched) {
        self.activityTouched();
    }
}

- (IBAction)touchFollowing:(id)sender {
    if (self.followingTouched) {
        self.followingTouched();
    }
}

- (IBAction)touchFollower:(id)sender {
    if (self.followerTouched) {
        self.followerTouched();
    }
}

- (void)touchRelationshipButton:(id)sender {
    if (self.relationshipTouched) {
        self.relationshipTouched();
    }
}
@end
