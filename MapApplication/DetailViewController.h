//
//  DetailViewController.h
//  MapApplication
//
//  Created by Zhan Shu on 2/16/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic,strong)NSDictionary *data;
@property (strong, nonatomic) IBOutlet MKMapView *mapDetail;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *vicinity;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *rating;


@end
