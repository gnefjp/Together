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
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.actionCode forKey:@"action"];
    
    [dict setValue:self.nickName forKey:@"nickname"];
    [dict setValue:self.birthDay forKey:@"birthday"];
    [dict setValue:self.sign forKey:@"signature_text"];
    [dict setValue:self.sex forKey:@"sex"];
    [dict setValue:self.recordId forKey:@"signature_record_id"];
    [dict setValue:self.avatarId forKey:@"pic_id"];
     [dict setValue:[[GEMTUserManager defaultManager] sId]  forKey:@"sid"];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",
                        self.requestUrl, [NSString urlArgsStringFromDictionary:dict]];
    NSURL* url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
//    [request addPostValue:self.recordId forKey:@"signature_record_id"];
//    [request addPostValue:self.avatarId forKey:@"pic_id"];
//    
//    [request addPostValue:[[GEMTUserManager defaultManager] sId] forKey:@"sid"];
    
    return request;
}

- (void) _requestFinished
{
    // 数据处理
    [self.delegate NetUserRequestSuccess:self];
}

@end
