//
//  DetailViewController.m
//  MapApplication
//
//  Created by Zhan Shu on 2/16/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "DetailViewController.h"
#import "GoogleMapAppDelegate.h"
#import "MapDetail.h"
#import <MapKit/MapKit.h>


@interface DetailViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation DetailViewController


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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self ShowDetail];
    //1
    GoogleMapAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
    
}



#pragma mark - Show Detail
/*
 * We implement this show detail funtion to display the specific information of each place.
 */

- (void)ShowDetail
{
    //set the basic information from the venue
    self.name.text = self.data[@"name"];
    self.vicinity.text = self.data[@"vicinity"];
    
    id type=self.data[@"types"];
    if([type isKindOfClass:[NSArray class]]){
        self.type.text=[type objectAtIndex:0];
    }
    self.rating.text=[NSString stringWithFormat:@"%@", self.data[@"rating"]];
    if([self.rating.text isEqual:@"(null)"])self.rating.text=@"NA";
    id imageD =self.data[@"icon"];
    if ([imageD isKindOfClass:[NSString class]]) {
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imageD]];
        UIImage *imageView = [UIImage imageWithData:imageData];
        self.image.image = imageView;
    }
    //extract the coordinate from the json object
    NSNumber *lat = self.data[@"geometry"][@"location"][@"lat"];
    NSNumber *lng = self.data[@"geometry"][@"location"][@"lng"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
    //zoom the map to the specific region containing our venue
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
    [self.mapDetail setRegion:[self.mapDetail regionThatFits:region] animated:YES];
    //create a pin so we can add to map
    MKPointAnnotation *point = [MKPointAnnotation new];
    point.coordinate = coord;
    point.title = self.data[@"name"];
    point.subtitle = self.data[@"vicinity"];
    //add the pin to the map
    [self.mapDetail addAnnotation:point];
}

#pragma mark - Mapkit delegate
/*
 * We implement this mapkit delegate method so that each pin that is added can be customized.
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"identifier"];
    [view setPinColor:MKPinAnnotationColorRed];
    [view setAnimatesDrop:YES];
    [view setCanShowCallout:YES];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (IBAction)DetailAdd:(id)sender {
    // Add Entry to PhoneBook Data base and reset all fields
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:@"Do you really want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
    
    //  1
     MapDetail* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"MapDetail" inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.mapData=self.data;
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  4
    self.data=NULL;
    //  5
    [self.view endEditing:YES];
    
}*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //  1
    MapDetail* newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"MapDetail" inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.mapData=self.data;
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //  4
    self.data=NULL;
    //  5
    [self.view endEditing:YES];
    
}
@end
