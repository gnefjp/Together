//
//  GEMTUserInfo.h
//  Together
//
//  Created by APPLE on 13-4-26.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserData.pb.h"

@interface GEMTUserInfo : NSObject
{
    NSString                    *_userId;
    NSString                    *_signatureRecordId;
    NSString                    *_avataId;
    
    NSString                    *_birthday;
    
    NSString                    *_userName;
    NSString                    *_passWord;
    
    NSString                    *_nickName;
    NSString                    *_signatureText;
    NSString                    *_age;
    
    NSString                    *_praiseNum;
    NSString                    *_visitNum;
    NSString                    *_followNum;
    NSString                    *_followedNum;
    UserGenderType              _eGenderType;
    
}

@property (strong, nonatomic) NSString             *userName;
@property (strong, nonatomic) NSString             *passWord;

@property (strong, nonatomic) NSString             *nickName;
@property (strong, nonatomic) NSString             *signatureText;
@property (strong, nonatomic) NSString             *birthday;

@property (strong, nonatomic) NSString             *userId;
@property (strong, nonatomic) NSString             *signatureRecordId;
@property (strong, nonatomic) NSString             *avataId;

@property (strong, nonatomic) NSString             *praiseNum;
@property (strong, nonatomic) NSString             *visitNum;
@property (strong, nonatomic) NSString             *followNum;
@property (strong, nonatomic) NSString             *followedNum;
@property (nonatomic)         UserGenderType       eGenderType;
@property (strong, nonatomic) NSString             *age;


- (void) setUserInfoWithLoginResPonse:(User_Info*)aUserInfo;
- (void) setAge:(NSString *)aBirth;

@end
