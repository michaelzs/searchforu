//
//  SearchResultViewController.h
//  MapApplication
//
//  Created by Zhan Shu on 2/14/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



@interface SearchResultViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapResult;
@property(nonatomic, strong) NSMutableArray *dataSource;
@property NSString *searchType;
@property NSString *searchName;
@property NSString *searchRadius;

@end
