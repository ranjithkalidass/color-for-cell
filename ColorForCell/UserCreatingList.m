//
//  UserCreatingList.m
//  ColorForCell
//
//  Created by Admin on 07/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "UserCreatingList.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "CustomCell.h"
#import "CreateAlarmController.h"

@implementation UserCreatingList
@synthesize userCreatedListTable;
@synthesize deletedTableview;
@synthesize completedTableview;
@synthesize newlist;
@synthesize completedListArray;
@synthesize deletedListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        delegateObj = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        newlist=[[NSMutableArray alloc]initWithObjects:@"", nil]; 

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
    [userCreatedListTable setDelegate:self];
    [userCreatedListTable setDataSource:self];       
    [userCreatedListTable setHidden:NO];
    [deletedTableview setHidden:YES];
    [completedTableview setHidden:YES];
    [userCreatedListTable setBackgroundColor:[UIColor blackColor]];
     //newlist=[[NSMutableArray alloc]initWithObjects:@"", nil]; 
    //deletedListArray=[[NSMutableArray alloc]init];
    completedListArray=[[NSMutableArray alloc]init];
    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithTitle:@"Deleted" style:UIBarButtonItemStyleDone target:self action:@selector(deletedlists)];
    self.navigationItem.rightBarButtonItem=add;
    [super viewDidLoad];                
    // Do any additional setup after loading the view from its nib.
}
-(void)deletedlists
{
    [userCreatedListTable setHidden:YES];
    [deletedTableview setHidden:NO];
    [UIView transitionWithView:deletedTableview duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^(void){
        [deletedTableview reloadData];
    }completion:NULL];    
    deletedTableview.separatorColor=[UIColor blackColor];  
    deletedTableview.backgroundColor=[UIColor blackColor]; 
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
    audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                   [NSURL fileURLWithPath:path] error:NULL];
    [audioplayer play]; 
}
- (void)viewDidUnload
{
    [self setDeletedTableview:nil];
    [self setCompletedTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.userCreatedListTable)
    {
    return 1;
    }
    else if(tableView==self.deletedTableview)
    {
        return 1;        
    }
    else if(tableView==self.completedTableview)
    {
        return 1;
    }
    return 0;    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.userCreatedListTable)
    {
        return newlist.count;
    }
    else if(tableView==self.deletedTableview)
    {
        return deletedListArray.count;        
    }
    else if(tableView==self.completedTableview)
    {
        return completedListArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.userCreatedListTable)
    {
    static NSString *cellIdentifier1=@"Cell1";
    CustomCell *cell=(CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];        
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:Nil];
        cell=[nib objectAtIndex:0];       
    } 
        UISwipeGestureRecognizer *swipeText=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperecognized:)];
        [swipeText setDelegate:self];
        [swipeText setDirection:UISwipeGestureRecognizerDirectionRight];
        [cell addGestureRecognizer:swipeText];     
        UISwipeGestureRecognizer * swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
        [swipeRecognizer setDelegate:self];
        [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [userCreatedListTable addGestureRecognizer:swipeRecognizer];
       
    cell.insertTextField.placeholder=@"Enter Your Items";
    cell.textLabel.text=[newlist objectAtIndex:indexPath.row];    
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    NSLog(@"User Created List");    
    return cell;
    }
    else if(tableView==self.deletedTableview)
    {
        static NSString *cellIdentifier1=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        cell.textLabel.text=[deletedListArray objectAtIndex:indexPath.row]; 
        cell.textLabel.highlightedTextColor=[UIColor magentaColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
        [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
        NSLog(@"deleted array list");
        return cell;  
    }
    else if(tableView==self.completedTableview)
    {
        static NSString *cellIdentifier1=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        cell.textLabel.text=[completedListArray objectAtIndex:indexPath.row]; 
        cell.textLabel.highlightedTextColor=[UIColor magentaColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
       
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, 24, 24);
        button.frame = frame;
        [button setBackgroundImage:[UIImage imageNamed:@"shopping.png"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        cell.accessoryView = button;        
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
        [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
     
        NSLog(@"completed list array");
        return cell; 
    }
    return 0;    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    if(tableView==self.userCreatedListTable){
        cell.backgroundColor = [self colorForIndex:indexPath.row];    }
    else if(tableView==self.deletedTableview){
        cell.backgroundColor=[self colorForIndex:indexPath.row];    }
    else if(tableView==self.completedTableview){
        cell.backgroundColor=[self colorForIndex:indexPath.row];    }
}
-(UIColor*)colorForIndex:(NSInteger)index
{    
    CGFloat sr = 217.0/255.0, sg = 0.0, sb = 22.0/255.0;
    CGFloat er = 234.0/255.0, eg = 175.0/255.0 , eb = 28.0/255.0;    
    int cutoff = 7;
    CGFloat delta = 1.0 / cutoff;
    if (count > cutoff )
        delta = 1.0 / count;
    else
        count = cutoff;    
    CGFloat s = delta * (count - index);
    CGFloat e = delta * index;    
    CGFloat red = sr * s + er * e;
    CGFloat green = sg * s + eg * e;
    CGFloat blue = sb * s + eb * e;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{   
    if(tableView==self.userCreatedListTable)
    {
        switch(section)
        {
            case 0:
                return @"Create Your List";
            default:
                return 0;
        }
    }
    else if(tableView==self.deletedTableview)
    {
        switch(section)
        {
            case 0:
                return @"Deleted List";
            default:
                return 0;
        }
    }
    return 0;
}
- (void)checkButtonTapped:(id)sender event:(id)event
{
    NSLog(@"Hello");
}
#pragma mark-Gestures 

-(void)swiperecognized:(UISwipeGestureRecognizer *)recognizer
{   
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {       
        CGPoint swipeLocation = [recognizer locationInView:userCreatedListTable];
        NSIndexPath *swipedIndexPath = [userCreatedListTable indexPathForRowAtPoint:swipeLocation];
        CustomCell *swipedCell = (CustomCell *)[userCreatedListTable cellForRowAtIndexPath:swipedIndexPath];
         CreateAlarmController *createalarmviewobj=[[CreateAlarmController alloc]initWithNibName:@"CreateAlarmController" bundle:nil];
        [self.navigationController pushViewController:createalarmviewobj animated:YES];
        createalarmviewobj.customTextField.text=swipedCell.insertTextField.text;       
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"SoundsCrate-SciFi-PowerUp1" ofType:@"wav"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
        NSLog(@"Completing the items user created List");             
        NSString *name=swipedCell.insertTextField.text;          
        [newlist addObject:name]; 
        [completedListArray addObject:name];
        NSLog(@"Completing the items in user create List value swiped is  %@",completedListArray);
        [UIView transitionWithView:userCreatedListTable duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
            [userCreatedListTable reloadData];         
        }completion:NULL];
    }
}
- (void)onSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{      
    if(recognizer.state == UIGestureRecognizerStateEnded)
    { 
        CGPoint swipeLocation = [recognizer locationInView:userCreatedListTable];
        NSIndexPath *swipedIndexPath = [userCreatedListTable indexPathForRowAtPoint:swipeLocation];
        UITableViewCell *swipedCell = [userCreatedListTable cellForRowAtIndexPath:swipedIndexPath];          
        [newlist removeObjectAtIndex:swipedIndexPath.row];
        [self.userCreatedListTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"SoundsCrate-SciFi-PowerDown3" ofType:@"wav"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
        NSLog(@"Deleting the items in tableview 1");         
        NSString *name=swipedCell.textLabel.text;        
        [deletedListArray addObject:name];        
        NSLog(@"Value of deletedlist array is %@",deletedListArray);
    }
}

@end
