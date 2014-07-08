//
//  StorePlaceTableViewController.m
//  MapApplication
//
//  Created by Zhan Shu on 4/5/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "StorePlaceTableViewController.h"
#import "GoogleMapAppDelegate.h"
#import "MapDetail.h"
#import "DetailViewController.h"

@interface StorePlaceTableViewController ()
@property (nonatomic,strong)NSMutableArray* fetchedData;
@property (nonatomic,strong)NSDictionary* placeData;

@end

@implementation StorePlaceTableViewController
@synthesize myTableView;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GoogleMapAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedData = (NSMutableArray*)[appDelegate getAllPlaceRecords];
    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
	

    GoogleMapAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.fetchedData = (NSMutableArray*)[appDelegate getAllPlaceRecords];
    if(self.fetchedData.count != 0){
    MapDetail * record = [self.fetchedData objectAtIndex:self.cellSelect.row];
    _placeData=(NSDictionary*)record.mapData;
    _placeData=NULL;
    //[self.myTableView reloadData];
    [self.tableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.fetchedData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"placecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MapDetail * record = [self.fetchedData objectAtIndex:indexPath.row];
    _placeData=(NSDictionary*)record.mapData;
    cell.textLabel.text =_placeData[@"name"];
    // Configure the cell...
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellSelect=indexPath;
    return indexPath;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellSelect=indexPath;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapDetail * record = [self.fetchedData objectAtIndex:self.cellSelect.row];
    _placeData=(NSDictionary*)record.mapData;
    UIViewController *viewControler=segue.destinationViewController;
    DetailViewController *detail=(DetailViewController *)viewControler;
    NSDictionary __strong *data=self.placeData;
    detail.data=data;
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
