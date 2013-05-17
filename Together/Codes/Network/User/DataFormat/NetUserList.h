//
//  NetUserList.h
//  Together
//
//  Created by APPLE on 13-5-17.
//  Copyright (c) 2013年 GMET. All rights reserved.
//

#import "NetItemList.h"

#pragma mark- Item
@interface NetUserItem : NetItem

@property (copy,   nonatomic) NSString              *userName;
@property (copy,   nonatomic) NSString              *nickName;

@property (assign, nonatomic) UserGenderType        genderType;

@property (copy,   nonatomic) NSString              *avataId;

@property (copy,   nonatomic) NSString              *signatureText;
@property (copy,   nonatomic) NSString              *signatureRecordId;

@property (copy,   nonatomic) NSString              *birthday;
@property (assign, nonatomic) int                   age;

@property (assign, nonatomic) NSInteger             praiseNum;
@property (assign, nonatomic) NSInteger             visitNum;

@property (assign, nonatomic) NSInteger             followNum;
@property (assign, nonatomic) NSInteger             followedNum;

@property (assign, nonatomic) UserRelationType      relationWithMe;

@end


#pragma mark- List
@interface NetUserList : NetItemList

@end
