// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "Data.pb.h"

@implementation DataRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [DataRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    [RoomDataRoot registerAllExtensions:registry];
    [UserDataRoot registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface List ()
@property BOOL isEnd;
@property (retain) NSMutableArray* mutableRoomInfoListList;
@property (retain) NSMutableArray* mutableUserInfoList;
@end

@implementation List

- (BOOL) hasIsEnd {
  return !!hasIsEnd_;
}
- (void) setHasIsEnd:(BOOL) value {
  hasIsEnd_ = !!value;
}
- (BOOL) isEnd {
  return !!isEnd_;
}
- (void) setIsEnd:(BOOL) value {
  isEnd_ = !!value;
}
@synthesize mutableRoomInfoListList;
@synthesize mutableUserInfoList;
- (void) dealloc {
  self.mutableRoomInfoListList = nil;
  self.mutableUserInfoList = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.isEnd = NO;
  }
  return self;
}
static List* defaultListInstance = nil;
+ (void) initialize {
  if (self == [List class]) {
    defaultListInstance = [[List alloc] init];
  }
}
+ (List*) defaultInstance {
  return defaultListInstance;
}
- (List*) defaultInstance {
  return defaultListInstance;
}
- (NSArray*) roomInfoListList {
  return mutableRoomInfoListList;
}
- (RoomInfo*) roomInfoListAtIndex:(int32_t) index {
  id value = [mutableRoomInfoListList objectAtIndex:index];
  return value;
}
- (NSArray*) userInfoList {
  return mutableUserInfoList;
}
- (User_Info*) userInfoAtIndex:(int32_t) index {
  id value = [mutableUserInfoList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasIsEnd) {
    [output writeBool:1 value:self.isEnd];
  }
  for (RoomInfo* element in self.roomInfoListList) {
    [output writeMessage:2 value:element];
  }
  for (User_Info* element in self.userInfoList) {
    [output writeMessage:3 value:element];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasIsEnd) {
    size += computeBoolSize(1, self.isEnd);
  }
  for (RoomInfo* element in self.roomInfoListList) {
    size += computeMessageSize(2, element);
  }
  for (User_Info* element in self.userInfoList) {
    size += computeMessageSize(3, element);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (List*) parseFromData:(NSData*) data {
  return (List*)[[[List builder] mergeFromData:data] build];
}
+ (List*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (List*)[[[List builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (List*) parseFromInputStream:(NSInputStream*) input {
  return (List*)[[[List builder] mergeFromInputStream:input] build];
}
+ (List*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (List*)[[[List builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (List*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (List*)[[[List builder] mergeFromCodedInputStream:input] build];
}
+ (List*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (List*)[[[List builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (List_Builder*) builder {
  return [[[List_Builder alloc] init] autorelease];
}
+ (List_Builder*) builderWithPrototype:(List*) prototype {
  return [[List builder] mergeFrom:prototype];
}
- (List_Builder*) builder {
  return [List builder];
}
@end

@interface List_Builder()
@property (retain) List* result;
@end

@implementation List_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[List alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (List_Builder*) clear {
  self.result = [[[List alloc] init] autorelease];
  return self;
}
- (List_Builder*) clone {
  return [List builderWithPrototype:result];
}
- (List*) defaultInstance {
  return [List defaultInstance];
}
- (List*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (List*) buildPartial {
  List* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (List_Builder*) mergeFrom:(List*) other {
  if (other == [List defaultInstance]) {
    return self;
  }
  if (other.hasIsEnd) {
    [self setIsEnd:other.isEnd];
  }
  if (other.mutableRoomInfoListList.count > 0) {
    if (result.mutableRoomInfoListList == nil) {
      result.mutableRoomInfoListList = [NSMutableArray array];
    }
    [result.mutableRoomInfoListList addObjectsFromArray:other.mutableRoomInfoListList];
  }
  if (other.mutableUserInfoList.count > 0) {
    if (result.mutableUserInfoList == nil) {
      result.mutableUserInfoList = [NSMutableArray array];
    }
    [result.mutableUserInfoList addObjectsFromArray:other.mutableUserInfoList];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (List_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (List_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 8: {
        [self setIsEnd:[input readBool]];
        break;
      }
      case 18: {
        RoomInfo_Builder* subBuilder = [RoomInfo builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addRoomInfoList:[subBuilder buildPartial]];
        break;
      }
      case 26: {
        User_Info_Builder* subBuilder = [User_Info builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addUserInfo:[subBuilder buildPartial]];
        break;
      }
    }
  }
}
- (BOOL) hasIsEnd {
  return result.hasIsEnd;
}
- (BOOL) isEnd {
  return result.isEnd;
}
- (List_Builder*) setIsEnd:(BOOL) value {
  result.hasIsEnd = YES;
  result.isEnd = value;
  return self;
}
- (List_Builder*) clearIsEnd {
  result.hasIsEnd = NO;
  result.isEnd = NO;
  return self;
}
- (NSArray*) roomInfoListList {
  if (result.mutableRoomInfoListList == nil) { return [NSArray array]; }
  return result.mutableRoomInfoListList;
}
- (RoomInfo*) roomInfoListAtIndex:(int32_t) index {
  return [result roomInfoListAtIndex:index];
}
- (List_Builder*) replaceRoomInfoListAtIndex:(int32_t) index with:(RoomInfo*) value {
  [result.mutableRoomInfoListList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (List_Builder*) addAllRoomInfoList:(NSArray*) values {
  if (result.mutableRoomInfoListList == nil) {
    result.mutableRoomInfoListList = [NSMutableArray array];
  }
  [result.mutableRoomInfoListList addObjectsFromArray:values];
  return self;
}
- (List_Builder*) clearRoomInfoListList {
  result.mutableRoomInfoListList = nil;
  return self;
}
- (List_Builder*) addRoomInfoList:(RoomInfo*) value {
  if (result.mutableRoomInfoListList == nil) {
    result.mutableRoomInfoListList = [NSMutableArray array];
  }
  [result.mutableRoomInfoListList addObject:value];
  return self;
}
- (NSArray*) userInfoList {
  if (result.mutableUserInfoList == nil) { return [NSArray array]; }
  return result.mutableUserInfoList;
}
- (User_Info*) userInfoAtIndex:(int32_t) index {
  return [result userInfoAtIndex:index];
}
- (List_Builder*) replaceUserInfoAtIndex:(int32_t) index with:(User_Info*) value {
  [result.mutableUserInfoList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (List_Builder*) addAllUserInfo:(NSArray*) values {
  if (result.mutableUserInfoList == nil) {
    result.mutableUserInfoList = [NSMutableArray array];
  }
  [result.mutableUserInfoList addObjectsFromArray:values];
  return self;
}
- (List_Builder*) clearUserInfoList {
  result.mutableUserInfoList = nil;
  return self;
}
- (List_Builder*) addUserInfo:(User_Info*) value {
  if (result.mutableUserInfoList == nil) {
    result.mutableUserInfoList = [NSMutableArray array];
  }
  [result.mutableUserInfoList addObject:value];
  return self;
}
@end
