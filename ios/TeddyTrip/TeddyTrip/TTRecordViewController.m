//
//  TTRecordViewController.m
//  TeddyTrip
//
//  Created by continuous integration on 26/11/13.
//
//

#import "TTRecordViewController.h"
#import "TTRecorder.h"

@interface TTRecordViewController ()
{
    CLLocationManager *_locationManager;
    TTLocationProvider *_locationProvider;
    TTRecorder *_recorder;
}

@end

@implementation TTRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _locationManager = [[CLLocationManager alloc] init];
    _locationProvider = [[TTLocationProvider alloc] initWithLocationManager:_locationManager];
    _recorder = [[TTRecorder alloc] initWithLocationProvider:_locationProvider timeProvider:[[TTTimeProvider alloc] initWithChangeInterval:1]];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didStartRecording:) name:kDidStartRecordingNotification object:_recorder];
    [center addObserver:self selector:@selector(didStopRecording:) name:kDidStopRecordingNotification object:_recorder];
    [center addObserver:self selector:@selector(distanceDidChange:) name:kDistanceDidChangeNotification object:_recorder];
    [center addObserver:self selector:@selector(durationDidChange:) name:kDurationDidChangeNotification object:_recorder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startButtonPressed:(id)sender
{
    [_recorder start];
}

- (void)stopButtonPressed:(id)sender
{
    [_recorder stop];
}

- (void)didStartRecording:(NSNotification*)note
{
    [[self startButton] setHidden:YES];
    [[self stopButton] setHidden:NO];
}

- (void)didStopRecording:(NSNotification*)note
{
    [[self startButton] setHidden:NO];
    [[self stopButton] setHidden:YES];
}

- (void)distanceDidChange:(NSNotification*)note
{
    NSNumber *distance = [[note userInfo] objectForKey:kUserInfoDistanceKey];
    [[self distanceLabel] setText:[NSString stringWithFormat:@"%.0f m", [distance doubleValue]]];
}

- (void)durationDidChange:(NSNotification *)note
{
    NSNumber *duration = [[note userInfo] objectForKey:kUserInfoDurationKey];
    [[self durationLabel] setText:[NSString stringWithFormat:@"%llu s", [duration unsignedLongLongValue] / 1000]];
}

@end
