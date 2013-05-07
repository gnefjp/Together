//
//  RoomCreateRequest.m
//  Together
//
//  Created by Gnef_jp on 13-4-24.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "RoomCreateRequest.h"

@implementation RoomCreateRequest

- (id) init
{
    self = [super init];
    if (self)
    {
        self.requestType = NetRoomRequestType_CreateRoom;
        
        self.address = [[NetAddressItem alloc] init];
    }
    return self;
}


- (ASIHTTPRequest *) _httpRequest
{
    NSURL* url = [NSURL URLWithString:self.requestUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.actionCode forKey:@"action"];
    
    [request addPostValue:_sid forKey:@"sid"];
    [request addPostValue:_ownerID forKey:@"userId"];
    [request addPostValue:_ownerNickname forKey:@"nickName"];
    
    [request addPostValue:_roomTitle forKey:@"title"];
    [request addPostValue:[NSString stringWithInt:_roomType] forKey:@"type"];
    
    [request addPostValue:_beginTime forKey:@"beginTime"];
    
    [request addPostValue:[NSString stringWithInt:_personNumLimit] forKey:@"limitPersonNum"];
    [request addPostValue:[NSString stringWithInt:_genderType] forKey:@"genderType"];
    
    [request addPostValue:[NSString stringWithDouble:_address.location.coordinate.longitude]
                   forKey:@"longitude"];
    [request addPostValue:[NSString stringWithDouble:_address.location.coordinate.latitude]
                   forKey:@"latitude"];
    [request addPostValue:_address.detailAddr forKey:@"detailAddr"];
    [request addPostValue:_address.addrRemark forKey:@"addrRemark"];
    
    _previewID = ([_previewID length] < 1) ? [NSString stringWithInt:_roomType] : _previewID;
    [request addPostValue:_previewID forKey:@"picId"];
    [request addPostValue:_recordID forKey:@"recordId"];
    
    return request;
}

@end

























