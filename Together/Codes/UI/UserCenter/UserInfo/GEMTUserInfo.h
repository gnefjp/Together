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
    int                  _userId;
    int                  _signatureRecordId;
    int                  _avataId;
    
    int                  _birthday;
    
    NSString             *_userName;
    NSString             *_passWord;
    
    NSString             *_nickName;
    NSString             *_signatureText;
    
    int                  _praiseNum;
    int                  _visitNum;
    int                  _followNum;
    int                  _followedNum;
}

- (void) setUserInfoWithLoginResPonse:(User_Info*)aUserInfo;

@property (strong, nonatomic) NSString             *userName;
@property (strong, nonatomic) NSString             *passWord;

@property (strong, nonatomic) NSString             *nickName;
@property (strong, nonatomic) NSString             *signatureText;

@property (nonatomic)   int                        userId;
@property (nonatomic)   int                        signatureRecordId;
@property (nonatomic)   int                        avataId;
@property (nonatomic)   int                        birthday;

@property (nonatomic)   int                        praiseNum;
@property (nonatomic)   int                        visitNum;
@property (nonatomic)   int                        followNum;
@property (nonatomic)   int                        followedNum;



@end
