//
//  GoogleMapViewController.m
//  MapApplication
//
//  Created by Zhan Shu on 2/14/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "GoogleMapViewController.h"
#import "SearchResultViewController.h"
@interface GoogleMapViewController ()
@property (strong, nonatomic) IBOutlet UIButton *mainButton;


@property(nonatomic, strong)NSString *dataSource;
@property(nonatomic, strong)CLLocationManager *locationManager;

@property(nonatomic) UIDynamicAnimator *animator;
@property(nonatomic) UIGravityBehavior *gravity;
@property(nonatomic) UICollisionBehavior *collision;



@end

@implementation GoogleMapViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //load the background image
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
    
    // reference Advanced IOS lab code sample
    [self.mainButton.layer setCornerRadius:self.mainButton.frame.size.width/2];
    [self.mainButton.layer setBorderColor:[[UIColor whiteColor]CGColor]];
    [self.mainButton.layer setBorderWidth:5.0f];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc]init];
    [self.gravity setAngle:M_PI/2 magnitude:3];
    [self.animator addBehavior:self.gravity];
    
     self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.mainButton]];
     self.collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collision];
    
    UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 430, 400, 435)];
    [self.view addSubview:barrier];
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x +
                                    barrier.frame.size.width, barrier.frame.origin.y);
    [self.collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin
                                  toPoint:rightEdge];
    
    
    double delayInSeconds = 2.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.gravity addItem:self.mainButton];
    });
   
}
- (IBAction)buttonDragged:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view.window];
    
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}
- (IBAction)buttonPressed:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Instruction" message:@"First, input name,type and range that you want to search. Then press the search. You will see search details. Press list tab the search results will be shown in a list. You can also save the place you like. Have fun! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Button
/*
 * This function ensures button action when press search button
 */

- (IBAction)getSearchQuery:(id)sender {
    
    self.queryName=self.textField.text;
    self.queryType=self.textFieldType.text;
    self.queryRadius=self.radius.text;
    if ([self.queryName isEqual:@""]||[self.queryType isEqual:@""]||[self.radius isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Reminder" message: @"You may dismiss name, type or range! The Result is not accurate!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
}

#pragma mark - TextField Return
/*
 * This function ensure that when press return button on keyboard, the keyboard will disappear
 */

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField|| theTextField == self.textFieldType||theTextField==self.radius) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - Information Pass
/*
 * This function will pass the information from googlemapviewcontroller to SearchResultViewController
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *viewControler=segue.destinationViewController;
    SearchResultViewController *searchResult=(SearchResultViewController *)viewControler;
    searchResult.searchName=self.queryName;
    searchResult.searchType=self.queryType;
    searchResult.searchRadius=self.queryRadius;
}

- (IBAction)button:(UIButton *)sender {
}
@end
