//
//  SearchResultViewController.m
//  MapApplication
//
//  Created by Zhan Shu on 2/14/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "SearchResultViewController.h"
#import <COMSMapManager/COMSMapManager.h>
#import "ResultTableViewController.h"
@import CoreLocation;
#define GOOGLE_API_KEY @"AIzaSyCK1_Ql-PHZr7aAndrSdt32RtsFvzv4nG4"

@interface SearchResultViewController ()
@property (nonatomic,strong) CLLocationManager *locationManager;
@property(assign)CLLocationCoordinate2D currentLocation;
@property(nonatomic, strong)NSDictionary *data;
@property(nonatomic, strong)MKPointAnnotation *point;


@end

@implementation SearchResultViewController
@synthesize mapResult;
@synthesize dataSource;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapResult.delegate=self;
    dataSource=[[NSMutableArray alloc] init];
    _locationManager = [[CLLocationManager alloc] init];
    _data=[[NSDictionary alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
    
   
    
    

}

- (void) changeValue
{
    UINavigationController *nav = [self.tabBarController.viewControllers objectAtIndex:1];
    ResultTableViewController *res= (ResultTableViewController *)[nav.viewControllers objectAtIndex:0];
    res.tableData=self.dataSource;
}
#pragma mark - Locationmanager delegate
/*
 * This function will update the user's location
 */

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //get the location, so that we can query data and update view
    CLLocation *location = locations[0];
    self.currentLocation = location.coordinate;
    [self.locationManager stopUpdatingLocation];
    //reloading data
    [self getData:^{}];
    //set 1 second delay
    [NSThread sleepForTimeInterval:1.0f];
    [self changeValue];
    //Show the annotation of the search result
    [self showAnnotation];
    
}
#pragma mark - Get Data
/*
 * This function will get the data from google places api
 */

-(void)getData:(void(^)())completion{
    
    double radius = [self.searchRadius intValue];
    _searchName=[_searchName stringByReplacingOccurrencesOfString:@" " withString: @"+"];
    
    
    
    [GoogleMapManager nearestVenuesForLatLong:self.currentLocation withinRadius:radius forQuery:_searchName queryType:_searchType googleMapsAPIKey:GOOGLE_API_KEY searchCompletion:^(NSMutableArray *results) {
        
        //clear before adding data, so we get expected results
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:results];
        NSLog(@"%@",self.dataSource);
        
        NSMutableDictionary *tmp=[[NSMutableDictionary alloc]init];
        
        for(NSDictionary *res in self.dataSource){
        NSNumber *lat = res[@"geometry"][@"location"][@"lat"];
        NSNumber *lng = res[@"geometry"][@"location"][@"lng"];
        CLLocation *locA = [[CLLocation alloc] initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude];
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
        CLLocationDistance distance = [locA distanceFromLocation:locB];
            NSLog(@"%f",distance);
            [tmp setObject: res forKey: @(distance)];
        }
        NSArray *sortedKeys = [[tmp  allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSMutableArray *sortedValues = [[NSMutableArray alloc] init];
        for(id key in sortedKeys) {
            id object = [tmp objectForKey:key];
           // NSLog(@"%@",key);
           // NSLog(@"%@",object);
            [sortedValues addObject:object];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:sortedValues];
        

        //reflect changes
        completion();
    }];
    
}

#pragma mark - Show Annotation
/*
 * Display the annotation of all the search results on the map
 */

-(void)showAnnotation{
    //set map region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentLocation, [self.searchRadius intValue]*2, [self.searchRadius intValue]*2);
    [self.mapResult setRegion:[self.mapResult regionThatFits:region] animated:YES];
    
    //If we went to add multiple annotations we need to put them in the NSMutableArray object
    NSMutableArray *annotations=[[NSMutableArray alloc] init];
    MKPointAnnotation *point;
    for(NSDictionary *res in self.dataSource){
     point=[[MKPointAnnotation alloc] init];
     NSNumber *lat = res[@"geometry"][@"location"][@"lat"];
     NSNumber *lng = res[@"geometry"][@"location"][@"lng"];
     CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
     point.coordinate = coord;
     point.title = res[@"name"];
     point.subtitle = res[@"vicinity"];
     [annotations addObject: point];
     }
    [self.mapResult addAnnotations:annotations];
}



#pragma mark - Mapkit delegate
/*
 We implement this mapkit delegate method so that each pin that is added can be customized.
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
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

#pragma mark - Information Pass
/*
 * This function will Pass the data from SeachResultViewController to ResultTableViewController
 */

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *viewControler=segue.destinationViewController;
    ResultTableViewController *resultTable=(ResultTableViewController *)viewControler;
    resultTable.tableData=self.dataSource;
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *viewControler=segue.destinationViewController;
    ResultTableViewController *resultTable=(ResultTableViewController *)viewControler;
    resultTable.tableData=self.dataSource;
}


@end
