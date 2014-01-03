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
    _recorder = [[TTRecorder alloc] initWithLocationProvider:_locationProvider timeProvider:[[TTTimeProvider alloc] init]];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didStartRecording:) name:kDidStartRecordingNotification object:nil];
    [center addObserver:self selector:@selector(didStopRecording:) name:kDidStopRecordingNotification object:nil];
    [center addObserver:self selector:@selector(distanceDidChange:) name:kDistanceDidChangeNotification object:nil];
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

@end
