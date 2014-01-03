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
#import "TTMockTimeProvider.h"

@interface TTTripStoreTests : XCTestCase
{
    TTTripStore *_tripStore;
    TTRecorder *_recorder;
    TTMockLocationProvider *_locationProvider;
    int _addNewTripCount;
}

@end

@implementation TTTripStoreTests

- (void)didAddNewTrip:(NSNotification*)note
{
    _addNewTripCount += 1;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    _locationProvider = [[TTMockLocationProvider alloc] init];
    _recorder = [[TTRecorder alloc] initWithLocationProvider:_locationProvider timeProvider:[[TTMockTimeProvider alloc] init]];
    _tripStore = [[TTTripStore alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddNewTrip:) name:kDidAddNewTripNotification object:_tripStore];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)testTripStoreDifferentTripsGetDifferentNames
{
    [self recordTrip:1];
    [self recordTrip:2];
    TTTrip *tripZero = [_tripStore tripAtIndex:0];
    TTTrip *tripOne = [_tripStore tripAtIndex:1];
    XCTAssertNotEqual([tripZero name], [tripOne name]);
}

- (void)testTripStoreTripsAreOrderedLatestFirst
{
    [self recordTrip:1];
    double firstDistance = [_recorder distanceMeters];
    [self recordTrip:2];
    double secondDistance = [_recorder distanceMeters];
    TTTrip *tripZero = [_tripStore tripAtIndex:0];
    TTTrip *tripOne = [_tripStore tripAtIndex:1];
    XCTAssertEqual(secondDistance, [tripZero distanceMeters]);
    XCTAssertEqual(firstDistance, [tripOne distanceMeters]);
}

- (void)testTripStoreNotifiesOnTripAddition
{
    [self recordTrip:1];
    XCTAssertEqual(1, _addNewTripCount);
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
