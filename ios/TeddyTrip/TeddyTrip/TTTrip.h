//
//  TTTrip.h
//  TeddyTrip
//
//  Created by continuous integration on 03/12/13.
//
//

#import <Foundation/Foundation.h>

@class TTRecorder;

@interface TTTrip : NSObject

- (id)initWithName:(NSString*)name fromRecorder:(TTRecorder*)recorder;

- (NSString*)name;
- (double)distanceMeters;
- (uint64_t)durationMilliseconds;

@end
