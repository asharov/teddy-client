//
//  TTTrip.m
//  TeddyTrip
//
//  Created by continuous integration on 03/12/13.
//
//

#import "TTTrip.h"
#import "TTRecorder.h"

@interface TTTrip ()
{
    NSString *_name;
    double _distanceMeters;
    uint64_t _durationMilliseconds;
}

@end

@implementation TTTrip

- (id)initWithName:(NSString *)name fromRecorder:(TTRecorder *)recorder
{
    self = [super init];
    if (self) {
        _name = name;
        _distanceMeters = [recorder distanceMeters];
        _durationMilliseconds = [recorder durationMilliseconds];
    }
    return self;
}

- (NSString *)name
{
    return _name;
}

- (double)distanceMeters
{
    return _distanceMeters;
}

- (uint64_t)durationMilliseconds
{
    return _durationMilliseconds;
}

@end
