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
    NSNumber                    *_userId;
    NSNumber                    *_signatureRecordId;
    NSNumber                    *_avataId;
    
    NSNumber                    *_birthday;
    
    NSString                    *_userName;
    NSString                    *_passWord;
    
    NSString                    *_nickName;
    NSString                    *_signatureText;
    
    NSNumber                    *_praiseNum;
    NSNumber                    *_visitNum;
    NSNumber                    *_followNum;
    NSNumber                    *_followedNum;
    NSNumber                    *_sex;
}

- (void) setUserInfoWithLoginResPonse:(User_Info*)aUserInfo;

@property (strong, nonatomic) NSString             *userName;
@property (strong, nonatomic) NSString             *passWord;

@property (strong, nonatomic) NSString             *nickName;
@property (strong, nonatomic) NSString             *signatureText;

@property (strong, nonatomic) NSNumber             *userId;
@property (strong, nonatomic) NSNumber             *signatureRecordId;
@property (strong, nonatomic) NSNumber             *avataId;
@property (strong, nonatomic) NSNumber             *birthday;

@property (strong, nonatomic) NSNumber             *praiseNum;
@property (strong, nonatomic) NSNumber             *visitNum;
@property (strong, nonatomic) NSNumber             *followNum;
@property (strong, nonatomic) NSNumber             *followedNum;
@property (strong, nonatomic) NSNumber             *sex;


@end
