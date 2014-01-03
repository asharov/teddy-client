//
//  TTMockTimeProvider.m
//  TeddyTrip
//
//  Created by Jaakko Kangasharju on 03/01/14.
//
//

#import "TTMockTimeProvider.h"

@interface TTMockTimeProvider ()
{
    uint64_t _currentTimeMilliseconds;
}

@end

@implementation TTMockTimeProvider

- (void)advance:(uint32_t)milliseconds
{
    _currentTimeMilliseconds += milliseconds;
    if ([self delegate]) {
        [[self delegate] timeDidChange:[self currentTime]];
    }
}

- (NSDate *)currentTime
{
    return [NSDate dateWithTimeIntervalSinceReferenceDate:_currentTimeMilliseconds / 1000.0];
}

@end
