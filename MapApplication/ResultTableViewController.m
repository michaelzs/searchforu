//
//  ResultTableViewController.m
//  MapApplication
//
//  Created by Zhan Shu on 2/16/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "ResultTableViewController.h"
#import "TableCell.h"
#import "DetailViewController.h"

@interface ResultTableViewController ()

@end

@implementation ResultTableViewController
@synthesize myTableView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    if (self.tableData==NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Reminder" message: @"You haven't done any search yet!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
    else{
    UINavigationController *nav = [self.tabBarController.viewControllers objectAtIndex:0];
    SearchResultViewController *res= (SearchResultViewController *)[nav.viewControllers objectAtIndex:1];
    self.tableData=res.dataSource;
    
        [super viewDidLoad];}
	// Do any additional setup after loading the view.
    


}

- (void) viewWillAppear:(BOOL)animated {
	 [self.myTableView reloadData];
    // You code here to update the view.
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

#pragma mark - TableView delegate
/*
 * We implement this TableView delegate method to set the data of each table cell.
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableIdentifier =@"TableCell";
    TableCell *cell=(TableCell *)[tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if(cell==nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //set name vicinity icon image on the table cell
    NSDictionary *data = self.tableData[indexPath.row];
    id name = data[@"name"];
    if ([name isKindOfClass:[NSString class]]) {
       cell.nameLabel.text= (NSString*)name;
    }
    id vicinity = data[@"vicinity"];
    if ([vicinity isKindOfClass:[NSString class]]) {
        cell.vicinityLabel.text = (NSString*)vicinity;
    }
    id image =data[@"icon"];
    if ([image isKindOfClass:[NSString class]]) {
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        UIImage *imageView = [UIImage imageWithData:imageData];
        cell.thumbnailImageView.image = imageView;
    }
     return cell;
}

/*
 * I customer the height of tablecell to 78
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

#pragma mark - Select
/*
 *  These Two function will work if you will or did select an table cell
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellSelect=indexPath;
    return indexPath;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
         self.cellSelect=indexPath;
    
}

#pragma mark - Pass Information
/*
 * This function will Pass the data from ResultViewController to DetailViewController
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *viewControler=segue.destinationViewController;
    DetailViewController *detail=(DetailViewController *)viewControler;
    NSDictionary __strong *data=self.tableData[self.cellSelect.row];
    detail.data=data;
}

@end
