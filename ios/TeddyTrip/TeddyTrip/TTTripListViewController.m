//
//  TTTripListViewController.m
//  TeddyTrip
//
//  Created by continuous integration on 03/12/13.
//
//

#import "TTTripListViewController.h"
#import "TTAppDelegate.h"
#import "TTTripStore.h"
#import "TTTrip.h"

@interface TTTripListViewController ()
{
    TTTripStore *_tripStore;
}

@end

@implementation TTTripListViewController

static NSString * const kCellReuseIdentifier = @"TripCell";

- (TTTripStore*)tripStore
{
    if (!_tripStore) {
        TTAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _tripStore = [appDelegate tripStore];
    }
    return _tripStore;
}

- (void)tripListDidUpdate:(NSNotification*)note
{
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tripListDidUpdate:) name:kDidAddNewTripNotification object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self tripStore] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellReuseIdentifier];
    }
    
    TTTrip *trip = [[self tripStore] tripAtIndex:[indexPath row]];
    [[cell textLabel] setText:[trip name]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%.0f m, %llu s", [trip distanceMeters], [trip durationMilliseconds] / 1000]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
