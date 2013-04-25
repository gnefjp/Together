// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class RoomInfo;
@class RoomInfo_Builder;

@interface RoomDataRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface RoomInfo : PBGeneratedMessage {
@private
  BOOL hasDistance_:1;
  BOOL hasId_:1;
  BOOL hasType_:1;
  BOOL hasStatus_:1;
  BOOL hasGenderType_:1;
  BOOL hasJoinPersonCount_:1;
  BOOL hasLimitPersonCount_:1;
  BOOL hasTitle_:1;
  BOOL hasOwnerNickname_:1;
  BOOL hasPicUrl_:1;
  BOOL hasAddress_:1;
  BOOL hasCreateTime_:1;
  Float64 distance;
  int32_t id;
  int32_t type;
  int32_t status;
  int32_t genderType;
  int32_t joinPersonCount;
  int32_t limitPersonCount;
  NSString* title;
  NSString* ownerNickname;
  NSString* picUrl;
  NSString* address;
  NSString* createTime;
}
- (BOOL) hasId;
- (BOOL) hasTitle;
- (BOOL) hasOwnerNickname;
- (BOOL) hasType;
- (BOOL) hasStatus;
- (BOOL) hasPicUrl;
- (BOOL) hasGenderType;
- (BOOL) hasDistance;
- (BOOL) hasJoinPersonCount;
- (BOOL) hasLimitPersonCount;
- (BOOL) hasAddress;
- (BOOL) hasCreateTime;
@property (readonly) int32_t id;
@property (readonly, retain) NSString* title;
@property (readonly, retain) NSString* ownerNickname;
@property (readonly) int32_t type;
@property (readonly) int32_t status;
@property (readonly, retain) NSString* picUrl;
@property (readonly) int32_t genderType;
@property (readonly) Float64 distance;
@property (readonly) int32_t joinPersonCount;
@property (readonly) int32_t limitPersonCount;
@property (readonly, retain) NSString* address;
@property (readonly, retain) NSString* createTime;

+ (RoomInfo*) defaultInstance;
- (RoomInfo*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (RoomInfo_Builder*) builder;
+ (RoomInfo_Builder*) builder;
+ (RoomInfo_Builder*) builderWithPrototype:(RoomInfo*) prototype;

+ (RoomInfo*) parseFromData:(NSData*) data;
+ (RoomInfo*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RoomInfo*) parseFromInputStream:(NSInputStream*) input;
+ (RoomInfo*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (RoomInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (RoomInfo*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface RoomInfo_Builder : PBGeneratedMessage_Builder {
@private
  RoomInfo* result;
}

- (RoomInfo*) defaultInstance;

- (RoomInfo_Builder*) clear;
- (RoomInfo_Builder*) clone;

- (RoomInfo*) build;
- (RoomInfo*) buildPartial;

- (RoomInfo_Builder*) mergeFrom:(RoomInfo*) other;
- (RoomInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (RoomInfo_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasId;
- (int32_t) id;
- (RoomInfo_Builder*) setId:(int32_t) value;
- (RoomInfo_Builder*) clearId;

- (BOOL) hasTitle;
- (NSString*) title;
- (RoomInfo_Builder*) setTitle:(NSString*) value;
- (RoomInfo_Builder*) clearTitle;

- (BOOL) hasOwnerNickname;
- (NSString*) ownerNickname;
- (RoomInfo_Builder*) setOwnerNickname:(NSString*) value;
- (RoomInfo_Builder*) clearOwnerNickname;

- (BOOL) hasType;
- (int32_t) type;
- (RoomInfo_Builder*) setType:(int32_t) value;
- (RoomInfo_Builder*) clearType;

- (BOOL) hasStatus;
- (int32_t) status;
- (RoomInfo_Builder*) setStatus:(int32_t) value;
- (RoomInfo_Builder*) clearStatus;

- (BOOL) hasPicUrl;
- (NSString*) picUrl;
- (RoomInfo_Builder*) setPicUrl:(NSString*) value;
- (RoomInfo_Builder*) clearPicUrl;

- (BOOL) hasGenderType;
- (int32_t) genderType;
- (RoomInfo_Builder*) setGenderType:(int32_t) value;
- (RoomInfo_Builder*) clearGenderType;

- (BOOL) hasDistance;
- (Float64) distance;
- (RoomInfo_Builder*) setDistance:(Float64) value;
- (RoomInfo_Builder*) clearDistance;

- (BOOL) hasJoinPersonCount;
- (int32_t) joinPersonCount;
- (RoomInfo_Builder*) setJoinPersonCount:(int32_t) value;
- (RoomInfo_Builder*) clearJoinPersonCount;

- (BOOL) hasLimitPersonCount;
- (int32_t) limitPersonCount;
- (RoomInfo_Builder*) setLimitPersonCount:(int32_t) value;
- (RoomInfo_Builder*) clearLimitPersonCount;

- (BOOL) hasAddress;
- (NSString*) address;
- (RoomInfo_Builder*) setAddress:(NSString*) value;
- (RoomInfo_Builder*) clearAddress;

- (BOOL) hasCreateTime;
- (NSString*) createTime;
- (RoomInfo_Builder*) setCreateTime:(NSString*) value;
- (RoomInfo_Builder*) clearCreateTime;
@end
