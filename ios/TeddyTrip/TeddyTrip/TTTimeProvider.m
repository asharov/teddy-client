//
//  TTTimeProvider.m
//  TeddyTrip
//
//  Created by Jaakko Kangasharju on 03/01/14.
//
//

#import "TTTimeProvider.h"

@implementation TTTimeProvider

- (id)initWithChangeInterval:(NSTimeInterval)interval
{
    self = [super init];
    if (self) {
        if (interval > 0) {
            [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        }
    }
    return self;
}

- (NSDate *)currentTime
{
    return [[NSDate alloc] init];
}

- (void)timerTick:(NSTimer *)timer
{
    if ([self delegate]) {
        [[self delegate] timeDidChange:[self currentTime]];
    }
}

@end
