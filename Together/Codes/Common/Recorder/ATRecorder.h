//
//  ATRecorder.h
//  ___PROJECTNAME___
//
//  Created by appletree on 13-2-26.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@class ATRecorder;

@protocol ATRecorderDelegate <NSObject>
@required
- (void)ATRecorderSuccess:(ATRecorder*)record;
- (void)ATRecorderFail:(ATRecorder*)record;

@end

@interface ATRecorder : NSObject<AVAudioRecorderDelegate>
{
    AVAudioRecorder             *_recorder;
    __weak id<ATRecorderDelegate>      _delegate;
    NSURL                       *_fileUrl;
    float                       _pTime;
}

@property (nonatomic, weak)  id<ATRecorderDelegate>     delegate;
@property (nonatomic, strong)  NSURL                     *fileUrl;
@property (nonatomic)  float                      pTime;

+ (id)startRecord:(NSURL *)fileUrl recordTime:(float)recordTime;
- (void)start;
- (void)stop;
@end
