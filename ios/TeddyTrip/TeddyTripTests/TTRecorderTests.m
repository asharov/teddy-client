//
//  TTRecorderTests.m
//  TTRecorderTests
//
//  Created by continuous integration on 26/11/13.
//
//

#import <XCTest/XCTest.h>
#import "TTRecorder.h"
#import "TTMockLocationProvider.h"

@interface TTRecorderTests : XCTestCase
{
    TTMockLocationProvider *_locationProvider;
    TTRecorder *_recorder;
    int _recorderStartCount;
    int _recorderStopCount;
    int _recorderDistanceCount;
}

@end

@implementation TTRecorderTests

- (void)didStartRecording:(NSNotification*)note
{
    _recorderStartCount += 1;
}

- (void)didStopRecording:(NSNotification*)note
{
    _recorderStopCount += 1;
}

- (void)distanceDidChange:(NSNotification*)note
{
    _recorderDistanceCount += 1;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _locationProvider = [[TTMockLocationProvider alloc] init];
    _recorder = [[TTRecorder alloc] initWithLocationProvider:_locationProvider];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didStartRecording:) name:kDidStartRecordingNotification object:_recorder];
    [center addObserver:self selector:@selector(didStopRecording:) name:kDidStopRecordingNotification object:_recorder];
    [center addObserver:self selector:@selector(distanceDidChange:) name:kDistanceDidChangeNotification object:_recorder];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}

- (void)testRecorderNotRecordingInInitialState
{
    XCTAssertFalse([_recorder isRecording]);
}

- (void)testRecorderStartStartsRecording
{
    [_recorder start];
    XCTAssertTrue([_recorder isRecording]);
}

- (void)testRecorderNotifiesWhenRecordingStarts
{
    [_recorder start];
    XCTAssertEqual(1, _recorderStartCount);
}

- (void)testRecorderKeepsTrackOfReceivedLocations
{
    [_recorder start];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    [_locationProvider addLocation:location];
    XCTAssertEqual(1U, [[_recorder trace] count]);
    XCTAssertEqual(location, [[_recorder trace] objectAtIndex:0]);
}

- (void)testRecorderAddsLocationsOnlyWhenRecording
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    [_locationProvider addLocation:location];
    XCTAssertEqual(0U, [[_recorder trace] count]);
}

- (void)testRecorderStopStopsRecording
{
    [_recorder start];
    [_recorder stop];
    XCTAssertFalse([_recorder isRecording]);
}

- (void)testRecorderNotifiesWhenRecordingStops
{
    [_recorder start];
    [_recorder stop];
    XCTAssertEqual(1, _recorderStopCount);
}

- (void)testStartingRecordingDoesNothingWhenRecording
{
    [_recorder start];
    [_recorder start];
    XCTAssertEqual(1, _recorderStartCount);
}

- (void)testStoppingRecordingDoesNothingWhenNotRecording
{
    [_recorder stop];
    XCTAssertEqual(0, _recorderStopCount);
}

- (void)testStartingNewRecordingClearsTrace
{
    [_recorder start];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    [_locationProvider addLocation:location];
    [_recorder stop];
    [_recorder start];
    XCTAssertEqual(0U, [[_recorder trace] count]);
}

- (void)testRecordingHasZeroDistanceWithOneLocation
{
    [_recorder start];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    [_locationProvider addLocation:location];
    XCTAssertEqual(0.0, [_recorder distanceMeters]);
}

- (void)testRecordingHasCorrectDistanceWithThreeLocations
{
    [_recorder start];
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:53.3 longitude:13.3];
    CLLocation *thirdLocation = [[CLLocation alloc] initWithLatitude:53.4 longitude:13.2];
    [_locationProvider addLocation:firstLocation];
    [_locationProvider addLocation:secondLocation];
    [_locationProvider addLocation:thirdLocation];
    double distance = [firstLocation distanceFromLocation:secondLocation] + [secondLocation distanceFromLocation:thirdLocation];
    XCTAssertEqualWithAccuracy(distance, [_recorder distanceMeters], 0.1);
}

- (void)testRecorderNotifiesOfDistanceChangeOnStart
{
    [_recorder start];
    XCTAssertEqual(1, _recorderDistanceCount);
}

- (void)testRecorderNotifiesOfDistanceChangeOnLocationUpdates
{
    [_recorder start];
    CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:53.2 longitude:13.4];
    CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:53.3 longitude:13.3];
    [_locationProvider addLocation:firstLocation];
    [_locationProvider addLocation:secondLocation];
    XCTAssertEqual(3, _recorderDistanceCount);
}

- (void)testRecordingHasZeroDurationAtStart
{
    [_recorder start];
    XCTAssertEqual((uint64_t)0, [_recorder durationMilliseconds]);
}

@end
