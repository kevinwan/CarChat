//
//  ActivityModel+Helper.m
//  CarChat
//
//  Created by Jia Zhao on 1/30/15.
//  Copyright (c) 2015 GongPingJia. All rights reserved.
//

#import "ActivityModel+Helper.h"
#import <AVFile.h>
#import "UserModel.h"
#import "UserModel+helper.h"

@implementation ActivityModel (Helper)

+ (instancetype)activityFromAVObject:(AVObject *)avobject
{
    ActivityModel * model = [[ActivityModel alloc]init];
    model.identifier = avobject.objectId;
    model.name = [avobject objectForKey:@"name"];
    model.posterUrl = [(AVFile *)[avobject objectForKey:@"poster"] url];
    model.destination = [avobject objectForKey:@"destination"];
    model.fromDate = [avobject objectForKey:@"fromDate"];
    model.toDate = [avobject objectForKey:@"toDate"];
    model.toplimit = [avobject objectForKey:@"toplimit"];
    model.payType = [[avobject objectForKey:@"payType"] integerValue];
    model.cost = [avobject objectForKey:@"cost"];
    model.invitationCode = [avobject objectForKey:@"invitationCode"];
    model.owner = [UserModel userFromAVUser:[avobject objectForKey:@"owner"]];
    model.createDate = [NSDateFormatter localizedStringFromDate:avobject.createdAt
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
    model.updateDate = [NSDateFormatter localizedStringFromDate:avobject.updatedAt
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
    model.notice = [avobject objectForKey:@"notice"];
    model.countOfParticipants = [avobject objectForKey:@"countOfParticipants"];
    return model;
}

- (CreateActivityParameter *)parameter
{
    CreateActivityParameter *parameter = (CreateActivityParameter *)[ParameterFactory parameterWithApi:ApiCreateActivity];
    parameter.name = self.name;
    parameter.destination = self.destination;
    parameter.fromDate = self.fromDate;
    parameter.toDate = self.toDate;
    parameter.toplimit = self.toplimit;
    parameter.payType = self.payType;
    parameter.cost = self.cost;
    parameter.poster = self.posterImage;
    parameter.posterUrl = self.posterUrl;
    parameter.notice = self.notice;
    return parameter;
}

//+ (instancetype)ActivityWithParameter:(CreateActivityParameter *)parameter
//{
//    ActivityModel * model = [ActivityModel new];
//    model.name = parameter.name;
//    model.destination = parameter.destination;
//    model.fromDate = parameter.fromDate;
//    
//    model.toplimit = parameter.toplimit;
//    model.payType = parameter.payType;
//    model.cost = parameter.cost;
//    model.posterImage = parameter.poster;
//    model.posterUrl = parameter.posterUrl;
//    return model;
//}
@end
