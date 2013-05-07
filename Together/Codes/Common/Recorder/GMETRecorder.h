//
//  ATRecorder.h
//  ___PROJECTNAME___
//
//  Created by appletree on 13-2-26.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@class GMETRecorder;

@protocol GMETRecorderDelegate <NSObject>
@required
- (void)GMETRecorderSuccess:(GMETRecorder*)record;
- (void)GMETRecorderFail:(GMETRecorder*)record;

@end

@interface GMETRecorder : NSObject<AVAudioRecorderDelegate>
{
    AVAudioRecorder                         *_recorder;
    __weak id<GMETRecorderDelegate>         _delegate;
    NSURL                                   *_fileUrl;
    float                                   _pTime;
}

@property (nonatomic, weak)     id<GMETRecorderDelegate>      delegate;
@property (nonatomic, strong)   NSURL                         *fileUrl;
@property (nonatomic)           float                         pTime;

+(id)startRecordWithTime:(float)recordTime;
+ (NSURL*)getRecordFileUrl;
+ (id)startRecord:(NSURL *)fileUrl recordTime:(float)recordTime;
- (void)start;
- (void)stop;
@end
