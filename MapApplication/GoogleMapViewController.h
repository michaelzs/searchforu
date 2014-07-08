//
//  GoogleMapViewController.h
//  MapApplication
//
//  Created by Zhan Shu on 2/14/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleMapViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *getSearchQuery;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *textFieldType;
@property (strong, nonatomic) IBOutlet UITextField *radius;

@property (copy, nonatomic) NSString *queryName;
@property (copy, nonatomic) NSString *queryType;
@property (copy, nonatomic) NSString *queryRadius;
@end
