//
//  UserInfoModify.m
//  Together
//
//  Created by APPLE on 13-5-8.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "UserInfoModifyRequest.h"
#import "GEMTUserManager.h"

@implementation UserInfoModifyRequest
@synthesize sign = _sign;
@synthesize sex = _sex;
@synthesize avatarId = _avatarId;

@synthesize recordId = _recordId;
@synthesize birthDay = _birthDay;
@synthesize nickName = _nickName;


- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetUserRequestType_ModifyInfo;
    }
    return self;
}

- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.actionCode forKey:@"action"];
    
    [request addPostValue:self.nickName forKey:@"nickname"];
//    [request addPostValue:self.birthDay forKey:@"birthday"];
    
    [request addPostValue:self.sign forKey:@"signature_text"];
    [request addPostValue:self.sex forKey:@"sex"];
    
//    [request addPostValue:self.recordId forKey:@"signature_record_id"];
//    [request addPostValue:self.avatarId forKey:@"pic_id"];
    
    [request addPostValue:[[GEMTUserManager shareInstance] sId] forKey:@"sid"];
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    [self.delegate NetUserRequestSuccess:self];
}

@end
