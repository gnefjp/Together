//
//  GEMTUserInfo.m
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "GEMTUserInfo.h"

@implementation GEMTUserInfo

@synthesize passWord = _passWord;
@synthesize userName = _userName;
@synthesize birthday = _birthday;
@synthesize followedNum = _followedNum;
@synthesize followNum = _followNum;
@synthesize nickName = _nickName;
@synthesize praiseNum = _praiseNum;
@synthesize signatureRecordId = _signatureRecordId;
@synthesize signatureText = _signatureText;
@synthesize userId = _userId;
@synthesize visitNum = _visitNum;

@synthesize avataId = _avataId;

- (void) setUserInfoWithLoginResPonse:(User_Info*)aUserInfo
{
    self.userId = [NSNumber numberWithInt:aUserInfo.uid];
    self.userName = aUserInfo.username;
    self.followedNum = [NSNumber numberWithInt:aUserInfo.followedNum];
    self.followNum = [NSNumber numberWithInt:aUserInfo.followNum];
    self.nickName = aUserInfo.nickName;
    self.praiseNum =[NSNumber numberWithInt:aUserInfo.praiseNum];
    self.signatureRecordId = [NSNumber numberWithInt:aUserInfo.signatureRecordId];
    self.signatureText = aUserInfo.signatureText;
    self.visitNum = [NSNumber numberWithInt:aUserInfo.visitNum];
}

@end
