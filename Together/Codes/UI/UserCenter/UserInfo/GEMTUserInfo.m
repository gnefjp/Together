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
@synthesize sex = _sex;
@synthesize avataId = _avataId;
@synthesize age = _age;

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
    self.sex = [NSNumber numberWithInt:aUserInfo.sex];
    self.birthday = aUserInfo.birthday;
    [self setAge:_birthday];
}

- (void)setAge:(NSString *)aBirth
{
    if (!aBirth) {
        _age = @"0";
    }else
    {
        _age = [NSString stringWithFormat:@"%d",2013 - [[[aBirth componentsSeparatedByString:@"-"] objectAtIndex:0] intValue]];
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_followedNum forKey:@"followedNum"];
    [aCoder encodeObject:_followNum forKey:@"followNum"];
    [aCoder encodeObject:_nickName forKey:@"nickName"];
    [aCoder encodeObject:_praiseNum forKey:@"praiseNum"];
    [aCoder encodeObject:_signatureRecordId forKey:@"signatureRecordId"];
    [aCoder encodeObject:_signatureText forKey:@"signatureText"];
    [aCoder encodeObject:_visitNum forKey:@"visitNum"];
    [aCoder encodeObject:_age forKey:@"age"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    _userId = [aDecoder decodeObjectForKey:@"userId"];
    _userName = [aDecoder decodeObjectForKey:@"userName"];
    _followedNum = [aDecoder decodeObjectForKey:@"followedNum"];
    _followNum = [aDecoder decodeObjectForKey:@"followNum"];
    _nickName = [aDecoder decodeObjectForKey:@"nickName"];
    _praiseNum = [aDecoder decodeObjectForKey:@"praiseNum"];
    _signatureRecordId = [aDecoder decodeObjectForKey:@"signatureRecordId"];
    _signatureText = [aDecoder decodeObjectForKey:@"signatureText"];
    _visitNum = [aDecoder decodeObjectForKey:@"visitNum"];
    _age = [aDecoder decodeObjectForKey:@"age"];
    return self;
}

@end
