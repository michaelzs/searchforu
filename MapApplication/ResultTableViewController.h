//
//  ResultTableViewController.h
//  MapApplication
//
//  Created by Zhan Shu on 2/16/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultViewController.h"

@interface ResultTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *tableData;
@property (nonatomic, strong)NSIndexPath *cellSelect;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@end


