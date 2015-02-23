//
//  AlarmListController.m
//  ColorForCell
//
//  Created by Admin on 15/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AlarmListController.h"
#import "UserCreatingList.h"
#import "ViewController.h"
@implementation AlarmListController
@synthesize alarmListTable;
@synthesize deletedNotificationTable;
@synthesize completedNotificationTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [alarmListTable setBackgroundColor:[UIColor blackColor]];
    [deletedNotificationTable setBackgroundColor:[UIColor blackColor]];
    [completedNotificationTable setBackgroundColor:[UIColor blackColor]];
    [alarmListTable setHidden:NO];
    [deletedNotificationTable setHidden:YES];
    [completedNotificationTable setHidden:YES];
    [self.navigationItem setHidesBackButton:YES];
    deletedarray=[[NSMutableArray alloc]init];
    completedarray=[[NSMutableArray alloc]init];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backtoview)];
    self.navigationItem.leftBarButtonItem=back;
    UIBarButtonItem *completed=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(completedtable)];
    self.navigationItem.rightBarButtonItem=completed;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
    [self setAlarmListTable:nil];
    [self setDeletedNotificationTable:nil];
    [self setCompletedNotificationTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark-UITableView Life Cycle(Datasource,Delegate Functions)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.alarmListTable)
    {
        return 1;
    }
    else if(tableView==self.deletedNotificationTable)
    {
        return 1;
    }
    else if(tableView==self.completedNotificationTable)
    {
        return 1;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.alarmListTable)
    {
        return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    }
    else if(tableView==self.deletedNotificationTable)
    {
        return deletedarray.count;
    }
    else if(tableView==self.completedNotificationTable)
    {
        return completedarray.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.alarmListTable)
    {
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //CustomTableView *cell1=(CustomTableView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }  
    UISwipeGestureRecognizer *swipeText=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperecognized:)];
    [swipeText setDelegate:self];
    [swipeText setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:swipeText];   
    UISwipeGestureRecognizer * swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
    [swipeRecognizer setDelegate:self];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:swipeRecognizer];        
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchtwo:)];
    [pinch setDelegate:self];
    [alarmListTable addGestureRecognizer:pinch];
        
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];    
    cell.textLabel.textColor=[UIColor redColor];
    [cell.textLabel setText:localNotification.alertBody];
    NSDateFormatter *formatter;
    NSString *dateString;    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];    
    dateString=[formatter stringFromDate:localNotification.fireDate];
    cell.detailTextLabel.textColor=[UIColor redColor];
    [cell.detailTextLabel setText:dateString];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame;
        [button setBackgroundImage:[UIImage imageNamed:@"1389875352_kalarm.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(checkButtonTappedalarm:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;         
    return cell;
    }
    else if(tableView==self.deletedNotificationTable)
    {
        [deletedNotificationTable setBackgroundColor:[UIColor grayColor]];
        static NSString *cellIdentifier=@"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //CustomTableView *cell1=(CustomTableView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }  
        cell.textLabel.text=[deletedarray objectAtIndex:indexPath.row];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame;
        [button setBackgroundImage:[UIImage imageNamed:@"1389978343_DeleteRed.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(checkButtonTapped1:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button; 

        return  cell;
    }
    else if(tableView==self.completedNotificationTable)
    {
        [completedNotificationTable setBackgroundColor:[UIColor grayColor]];
        static NSString *cellIdentifier=@"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //CustomTableView *cell1=(CustomTableView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }  
        cell.textLabel.text=[completedarray objectAtIndex:indexPath.row];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame;
        [button setBackgroundImage:[UIImage imageNamed:@"1389981191_task_completed.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button; 
        return  cell;
    }
    return 0;
}
- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.completedNotificationTable];
    NSIndexPath *indexPath = [self.completedNotificationTable indexPathForRowAtPoint: currentTouchPosition];
    UITableViewCell *swipedCell =[completedNotificationTable cellForRowAtIndexPath:indexPath];
    NSString *name=swipedCell.textLabel.text;
    [completedarray removeObject:name];    
    [completedNotificationTable reloadData];
}
- (void)checkButtonTapped1:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.deletedNotificationTable];
    NSIndexPath *indexPath = [self.deletedNotificationTable indexPathForRowAtPoint: currentTouchPosition];
    UITableViewCell *swipedCell =[deletedNotificationTable cellForRowAtIndexPath:indexPath];
    NSString *name=swipedCell.textLabel.text;
    [deletedarray removeObject:name];
    [deletedNotificationTable reloadData];
}
-(void)checkButtonTappedalarm:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.alarmListTable];
    NSIndexPath *indexPath = [self.alarmListTable indexPathForRowAtPoint: currentTouchPosition];
   // UITableViewCell *swipedCell =[alarmListTable cellForRowAtIndexPath:indexPath];    
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
    UIApplication* app = [UIApplication sharedApplication];
    [app cancelLocalNotification:localNotification];
    [alarmListTable reloadData];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.alarmListTable)
    {
        cell.backgroundColor=[UIColor grayColor];
    }
    else if(tableView==self.deletedNotificationTable)
    {
        cell.backgroundColor=[UIColor grayColor];
    }
    else if(tableView==self.completedNotificationTable)
    {
        cell.backgroundColor=[UIColor grayColor];
    }
    
}
#pragma mark-calling the bar button actions
-(void)backtoview
{
    [self.navigationController popToRootViewControllerAnimated:YES];   
}
-(void)completedtable
{
    [alarmListTable setHidden:YES];
    [deletedNotificationTable setHidden:YES];
    [completedNotificationTable setHidden:NO];
    self.navigationItem.rightBarButtonItem=nil;
    UIBarButtonItem *clear=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearallcompleted)];
    self.navigationItem.rightBarButtonItem=clear;
    self.navigationItem.title=@"Completed Memo's";
    [UIView transitionWithView:completedNotificationTable duration:1 options:UIViewAnimationTransitionCurlUp animations:^(void){
        [completedNotificationTable reloadData];
    }completion:NULL]; 
}
-(void)clearallcompleted
{
    actionsheetcompleted=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete All Completed Memo" otherButtonTitles:nil, nil];
    [actionsheetcompleted showInView:self.view];
    
}
#pragma mark-Pinch Gestures 
-(void)pinchtwo:(UIPinchGestureRecognizer *)recognizer
{
    [alarmListTable setHidden:YES];
    [deletedNotificationTable setHidden:NO];
    self.navigationItem.rightBarButtonItem=nil;
    UIBarButtonItem *clear=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearall)];
    self.navigationItem.rightBarButtonItem=clear;
    self.navigationItem.title=@"Deleted Memo's";
    [UIView transitionWithView:deletedNotificationTable duration:1 options:UIViewAnimationTransitionCurlUp animations:^(void){
        [deletedNotificationTable reloadData];
    }completion:NULL]; 
}
-(void)clearall
{
  actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete All Memo" otherButtonTitles:nil, nil];
    [actionsheet showInView:self.view];
    
}
#pragma mark-ActionSheet Delegate Function
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet==actionsheetcompleted)
    {
        if(buttonIndex==0)
        {
            [completedarray removeAllObjects];
            [UIView transitionWithView:completedNotificationTable duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
                [completedNotificationTable reloadData];
            }completion:NULL];  
        }
 
    }
    else if(actionSheet==actionsheet)
    {
    if(buttonIndex==0)
    {
        [deletedarray removeAllObjects];
        [UIView transitionWithView:deletedNotificationTable duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            [deletedNotificationTable reloadData];
        }completion:NULL];  
    }
    }
}
#pragma mark-Swipe Gestures
-(void)swiperecognized:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {   
        CGPoint swipeLocation = [recognizer locationInView:alarmListTable];
        NSIndexPath *swipedIndexPath = [alarmListTable indexPathForRowAtPoint:swipeLocation];
        UITableViewCell *swipedCell =[alarmListTable cellForRowAtIndexPath:swipedIndexPath];          
        CGRect frame = swipedCell.textLabel.frame;
        UILabel *strikethrough = [[UILabel alloc] initWithFrame:frame];
        strikethrough.opaque = YES;
        strikethrough.backgroundColor = [UIColor clearColor];
        strikethrough.text = @"------------";        
        strikethrough.lineBreakMode = UILineBreakModeClip;
        [swipedCell addSubview:strikethrough];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame1 = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame1;
        [button setBackgroundImage:[UIImage imageNamed:@"1389981191_task_completed.png"] forState:UIControlStateNormal];        
        [button addTarget:self action:@selector(checkButtonTappedalarm:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        swipedCell.accessoryView = button; 
        NSString *name=swipedCell.textLabel.text;
        [completedarray addObject:name];   
        swipedCell.backgroundColor=[UIColor grayColor];  
    }
    
}
- (void)onSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{      
    if(recognizer.state == UIGestureRecognizerStateEnded)
    { 
        CGPoint swipeLocation = [recognizer locationInView:alarmListTable];
        NSIndexPath *swipedIndexPath = [alarmListTable indexPathForRowAtPoint:swipeLocation];
        UITableViewCell *swipedCell =[alarmListTable cellForRowAtIndexPath:swipedIndexPath];          
        CGRect frame = swipedCell.textLabel.frame;
        UILabel *strikethrough = [[UILabel alloc] initWithFrame:frame];
        strikethrough.opaque = YES;
        strikethrough.backgroundColor = [UIColor clearColor];
        strikethrough.text = @"XXXXXXXXX";        
        strikethrough.lineBreakMode = UILineBreakModeClip;
        [swipedCell addSubview:strikethrough];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame1 = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame1;
        [button setBackgroundImage:[UIImage imageNamed:@"1389978343_DeleteRed.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(checkButtonTappedalarm:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        swipedCell.accessoryView = button;
        NSString *name=swipedCell.textLabel.text;
        [deletedarray addObject:name];
        swipedCell.backgroundColor=[UIColor grayColor];        
    }       
}

@end
