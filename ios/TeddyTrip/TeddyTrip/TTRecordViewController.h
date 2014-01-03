//
//  TTRecordViewController.h
//  TeddyTrip
//
//  Created by continuous integration on 26/11/13.
//
//

#import <UIKit/UIKit.h>
#import "TTRecorder.h"

@interface TTRecordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;

@end
