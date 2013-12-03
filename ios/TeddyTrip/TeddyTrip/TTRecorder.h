//
//  TTRecorder.h
//  TeddyTrip
//
//  Created by continuous integration on 01/12/13.
//
//

#import <Foundation/Foundation.h>
#import "TTLocationProvider.h"

static NSString * const kDidStartRecordingNotification = @"TTDidStartRecording";
static NSString * const kDidStopRecordingNotification = @"TTDidStopRecording";
static NSString * const kDistanceDidChangeNotification = @"TTDistanceDidChange";
static NSString * const kUserInfoDistanceKey = @"distance";

@interface TTRecorder : NSObject <TTLocationProviderDelegate>

@property (readonly) BOOL isRecording;
@property (readonly) double distanceMeters;
@property (readonly) NSArray *trace;

- (id)initWithLocationProvider:(TTLocationProvider *)locationProvider;

- (void)start;
- (void)stop;

@end
