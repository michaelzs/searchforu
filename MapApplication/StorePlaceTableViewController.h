//
//  StorePlaceTableViewController.h
//  MapApplication
//
//  Created by Zhan Shu on 4/5/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StorePlaceTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSIndexPath *cellSelect;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
