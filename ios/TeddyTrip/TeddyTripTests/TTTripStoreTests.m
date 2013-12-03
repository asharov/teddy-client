//
//  TTTripStoreTests.m
//  TeddyTrip
//
//  Created by continuous integration on 03/12/13.
//
//

#import <XCTest/XCTest.h>
#import "TTTripStore.h"
#import "TTRecorder.h"
#import "TTTrip.h"
#import "TTMockLocationProvider.h"

@interface TTTripStoreTests : XCTestCase
{
    TTTripStore *_tripStore;
    TTRecorder *_recorder;
    TTMockLocationProvider *_locationProvider;
}

@end

@implementation TTTripStoreTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _locationProvider = [[TTMockLocationProvider alloc] init];
    _recorder = [[TTRecorder alloc] initWithLocationProvider:_locationProvider];
    _tripStore = [[TTTripStore alloc] initWithRecorder:_recorder];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testTripStoreEmptyOnCreation
{
    XCTAssertEqual(0, [_tripStore count]);
}

- (void)testTripStoreHasPositiveCountAfterRecording
{
    [self recordTrip:0];
    XCTAssertEqual(1, [_tripStore count]);
}

- (void)testTripStoreHasTripAfterRecording
{
    [self recordTrip:2];
    TTTrip *trip = [_tripStore tripAtIndex:0];
    XCTAssertEqual([_recorder distanceMeters], [trip distanceMeters]);
}

- (void)testTripStoreRecordedTripHasName
{
    [self recordTrip:2];
    TTTrip *trip = [_tripStore tripAtIndex:0];
    XCTAssertTrue([[trip name] length] > 0);
}

- (void)recordTrip:(int)length
{
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:53.3 longitude:13.3];
    CLLocation *thirdLocation = [[CLLocation alloc] initWithLatitude:53.4 longitude:13.2];
    [_recorder start];
    if (length > 0) {
        [_locationProvider addLocation:firstLocation];
        if (length > 1) {
            [_locationProvider addLocation:secondLocation];
            if (length > 2) {
                [_locationProvider addLocation:thirdLocation];
            }
        }
    }
    [_recorder stop];
}

@end
