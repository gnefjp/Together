// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class User_Info;
@class User_Info_Builder;
typedef enum {
  UserRelationNorelation = 0,
  UserRelationFollow = 1,
  UserRelationFans = 2,
  UserRelationFolloweach = 3,
  UserRelationOwn = 4,
} UserRelation;

BOOL UserRelationIsValidValue(UserRelation value);


@interface UserDataRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface User_Info : PBGeneratedMessage {
@private
  BOOL hasUid_:1;
  BOOL hasSignatureRecordId_:1;
  BOOL hasPraiseNum_:1;
  BOOL hasVisitNum_:1;
  BOOL hasFollowedNum_:1;
  BOOL hasFollowNum_:1;
  BOOL hasSex_:1;
  BOOL hasPicId_:1;
  BOOL hasUsername_:1;
  BOOL hasNickName_:1;
  BOOL hasBirthday_:1;
  BOOL hasSignatureText_:1;
  int32_t uid;
  int32_t signatureRecordId;
  int32_t praiseNum;
  int32_t visitNum;
  int32_t followedNum;
  int32_t followNum;
  int32_t sex;
  int32_t picId;
  NSString* username;
  NSString* nickName;
  NSString* birthday;
  NSString* signatureText;
}
- (BOOL) hasUid;
- (BOOL) hasUsername;
- (BOOL) hasNickName;
- (BOOL) hasBirthday;
- (BOOL) hasSignatureText;
- (BOOL) hasSignatureRecordId;
- (BOOL) hasPraiseNum;
- (BOOL) hasVisitNum;
- (BOOL) hasFollowedNum;
- (BOOL) hasFollowNum;
- (BOOL) hasSex;
- (BOOL) hasPicId;
@property (readonly) int32_t uid;
@property (readonly, retain) NSString* username;
@property (readonly, retain) NSString* nickName;
@property (readonly, retain) NSString* birthday;
@property (readonly, retain) NSString* signatureText;
@property (readonly) int32_t signatureRecordId;
@property (readonly) int32_t praiseNum;
@property (readonly) int32_t visitNum;
@property (readonly) int32_t followedNum;
@property (readonly) int32_t followNum;
@property (readonly) int32_t sex;
@property (readonly) int32_t picId;

+ (User_Info*) defaultInstance;
- (User_Info*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (User_Info_Builder*) builder;
+ (User_Info_Builder*) builder;
+ (User_Info_Builder*) builderWithPrototype:(User_Info*) prototype;

+ (User_Info*) parseFromData:(NSData*) data;
+ (User_Info*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (User_Info*) parseFromInputStream:(NSInputStream*) input;
+ (User_Info*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (User_Info*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (User_Info*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface User_Info_Builder : PBGeneratedMessage_Builder {
@private
  User_Info* result;
}

- (User_Info*) defaultInstance;

- (User_Info_Builder*) clear;
- (User_Info_Builder*) clone;

- (User_Info*) build;
- (User_Info*) buildPartial;

- (User_Info_Builder*) mergeFrom:(User_Info*) other;
- (User_Info_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (User_Info_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUid;
- (int32_t) uid;
- (User_Info_Builder*) setUid:(int32_t) value;
- (User_Info_Builder*) clearUid;

- (BOOL) hasUsername;
- (NSString*) username;
- (User_Info_Builder*) setUsername:(NSString*) value;
- (User_Info_Builder*) clearUsername;

- (BOOL) hasNickName;
- (NSString*) nickName;
- (User_Info_Builder*) setNickName:(NSString*) value;
- (User_Info_Builder*) clearNickName;

- (BOOL) hasBirthday;
- (NSString*) birthday;
- (User_Info_Builder*) setBirthday:(NSString*) value;
- (User_Info_Builder*) clearBirthday;

- (BOOL) hasSignatureText;
- (NSString*) signatureText;
- (User_Info_Builder*) setSignatureText:(NSString*) value;
- (User_Info_Builder*) clearSignatureText;

- (BOOL) hasSignatureRecordId;
- (int32_t) signatureRecordId;
- (User_Info_Builder*) setSignatureRecordId:(int32_t) value;
- (User_Info_Builder*) clearSignatureRecordId;

- (BOOL) hasPraiseNum;
- (int32_t) praiseNum;
- (User_Info_Builder*) setPraiseNum:(int32_t) value;
- (User_Info_Builder*) clearPraiseNum;

- (BOOL) hasVisitNum;
- (int32_t) visitNum;
- (User_Info_Builder*) setVisitNum:(int32_t) value;
- (User_Info_Builder*) clearVisitNum;

- (BOOL) hasFollowedNum;
- (int32_t) followedNum;
- (User_Info_Builder*) setFollowedNum:(int32_t) value;
- (User_Info_Builder*) clearFollowedNum;

- (BOOL) hasFollowNum;
- (int32_t) followNum;
- (User_Info_Builder*) setFollowNum:(int32_t) value;
- (User_Info_Builder*) clearFollowNum;

- (BOOL) hasSex;
- (int32_t) sex;
- (User_Info_Builder*) setSex:(int32_t) value;
- (User_Info_Builder*) clearSex;

- (BOOL) hasPicId;
- (int32_t) picId;
- (User_Info_Builder*) setPicId:(int32_t) value;
- (User_Info_Builder*) clearPicId;
@end

