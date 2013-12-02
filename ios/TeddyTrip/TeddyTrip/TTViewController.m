//
//  TTViewController.m
//  TeddyTrip
//
//  Created by continuous integration on 26/11/13.
//
//

#import "TTViewController.h"
#import "TTRecorder.h"

@interface TTViewController ()
{
    TTRecorder *_recorder;
}

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _recorder = [[TTRecorder alloc] init];
    [_recorder setDelegate:self];
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

- (void)didStartRecording
{
    [[self startButton] setHidden:YES];
    [[self stopButton] setHidden:NO];
}

@end