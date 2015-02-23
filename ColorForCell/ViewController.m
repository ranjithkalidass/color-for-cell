//
//  ViewController.m
//  ColorForCell
//
//  Created by Admin on 03/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UserCreatingList.h"
#import "AppDelegate.h"
#import "AlarmListController.h"
@implementation ViewController

@synthesize mytableview4;
@synthesize companynameText;
@synthesize mytableview3;
@synthesize mytableview2;
@synthesize myTableview;
@synthesize archieve3;
@synthesize newlist3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
         delegateobj = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }   
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    //playing the sounds initially....
    NSString *path = [[NSBundle mainBundle]pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
    audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                   [NSURL fileURLWithPath:path] error:NULL];
    [audioplayer play];
    //color for navigation bar
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //initially tableview 2,3,4 is set to hidden except tableview 1
    [myTableview setHidden:YES];
    [mytableview2 setHidden:YES];
    [mytableview3 setHidden:YES];
    [mytableview4 setHidden:YES];
    [self.navigationItem setHidesBackButton:YES];
    sumtwoimage=[[UIImageView alloc]initWithFrame:CGRectMake(11, 41, 209, 38)];
    sumtwoimage.image=[UIImage imageNamed:@"logo.png"];
    [self.view addSubview:sumtwoimage];  
    UIBarButtonItem *guidelines=[[UIBarButtonItem alloc]initWithTitle:@"GuideLine" style:UIBarButtonItemStyleBordered target:self action:@selector(gudielinefortable)];
    self.navigationItem.leftBarButtonItem=guidelines;
    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertentries)];
    self.navigationItem.rightBarButtonItem=add;
    //allocation of MutableArray....
    archieve1=[[NSMutableArray alloc]init];
    archieve2=[[NSMutableArray alloc]init];
    archieve3=[[NSMutableArray alloc]init];
    newlist1=[[NSMutableArray alloc]init];
    newlist2=[[NSMutableArray alloc]init];
    //assigning list of items to be displayed in tableview 1
    listof_Items=[[NSMutableArray alloc]initWithObjects:@"Swipe Left To Delete",@"Swipe Right To Complete",@"Pinch To Open Menu",@"Guided By IOS Team",@"Done By Ranjith Trainee",nil];
    //assigning list of items1 to be displayed in tableview 2
    listof_Items1=[[NSMutableArray alloc]initWithObjects:@"Create User List",@"Show AlarmTable",@"Move to Guidelines",nil];
    //setting the seperator color for tablevew 1
    myTableview.separatorColor=[UIColor blackColor];
    count=listof_Items.count;
    myTableview.backgroundColor=[UIColor blackColor];   
    //using Swipe gestures for tableview 1
    UISwipeGestureRecognizer * swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
    [swipeRecognizer setDelegate:self];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [myTableview addGestureRecognizer:swipeRecognizer];//assigning left gestures to tableview1-to delete cells
    //using Swipe gestures for tableview 2
    UISwipeGestureRecognizer * swipeRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
    [swipeRecognizer1 setDelegate:self];
    [swipeRecognizer1 setDirection:UISwipeGestureRecognizerDirectionLeft]; 
    [mytableview2 addGestureRecognizer:swipeRecognizer1];//assigning left gestres to tableview2-to delete cells
    //using Swipe gestures for tableview
    UISwipeGestureRecognizer * swipecomplete = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
    [swipecomplete setDelegate:self];
    [swipecomplete setDirection:UISwipeGestureRecognizerDirectionRight];
    [myTableview addGestureRecognizer:swipecomplete];//assigning right gestures to tableview1-to complete cells
    UISwipeGestureRecognizer * swipecomplete1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
    [swipecomplete1 setDelegate:self];
    [swipecomplete1 setDirection:UISwipeGestureRecognizerDirectionRight];      
    [mytableview2 addGestureRecognizer:swipecomplete1];//assigning right gestures to tableview2-to complete cells
    UIPinchGestureRecognizer *pinchrecognizer=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureRecognizer:)];
    [pinchrecognizer setDelegate:self];
    [myTableview addGestureRecognizer:pinchrecognizer];
        [super viewDidLoad];    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)gudielinefortable
{
    [myTableview setHidden:NO];
    [companynameText setHidden:YES];
    [mytableview2 setHidden:YES];
    [mytableview3 setHidden:YES];
    [mytableview4 setHidden:YES];
    imageview.hidden=YES;
    sumtwoimage.hidden=YES;
}
- (void)viewDidUnload
{
    [self setMyTableview:nil];
    [self setMytableview2:nil];
    [self setMytableview3:nil];
    [self setMytableview3:nil];
    [self setMytableview4:nil];
    [self setCompanynameText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark-number of section in tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.mytableview3)
    {
        return 3;
    }
    else if(tableView==self.mytableview4)
    {
        return 3;
    }
    return 1;
}

#pragma mark-assigning number of rows in section in tableview....
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //number of rows in section of table view 1
    if(tableView==self.myTableview)
    {
    return listof_Items.count;
    }
    //number of rows in section of table view 2
    else if(tableView==self.mytableview2)
    {
        return  listof_Items1.count;
    }
    //number of rows in section of table view 3
    else if(tableView==self.mytableview3)
    {
        if(section==0)
        {
        return archieve1.count;        
        }
        else if(section==1)
        {
        return archieve2.count;
        }
        else if(section==2)
        {
        return  archieve3.count;
        }
    }
    //number of rows in section of table view 4
    else if(tableView==self.mytableview4)
    {
        if(section==0)
        {
            return newlist1.count;        
        }
        else if(section==1)
        {
            return newlist2.count;
        }
        else if(section==2)
        {
            return newlist3.count;
        }
    }
   return 0;
}
#pragma mark-setting height for the header in section 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{
    if(tableView==self.mytableview3)
    {
    if ([tableView.dataSource tableView:mytableview3 numberOfRowsInSection:section] == 0) 
    {
        return 0;
    } else 
    {
       
    }
    }
    else if(tableView==self.mytableview4)
    {
        if ([tableView.dataSource tableView:mytableview4 numberOfRowsInSection:section] == 0) 
        {
            return 0;
        } else 
        {
            
        }   
    }
    return 30;
}
#pragma mark-assigning values to each all the four tables...
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //initializing tableview 1 and setting the array of items to tableview cell....
    if(tableView==self.myTableview)
    {
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[listof_Items objectAtIndex:indexPath.row]; 
    cell.textLabel.highlightedTextColor=[UIColor magentaColor];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
        NSLog(@"Table view 1");
    return cell;
    }
     //initializing tableview 2 and setting the array of items to tableview cell....
    else if(tableView==self.mytableview2)
    {
        static NSString *cellIdentifier1=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        cell.textLabel.text=[listof_Items1 objectAtIndex:indexPath.row]; 
        cell.textLabel.highlightedTextColor=[UIColor magentaColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        NSLog(@"Table view 2");
        return cell;
    }
     //tableview 3 and setting the array of items to tableview cell....
    else if(tableView==self.mytableview3)
    {
        static NSString *cellIdentifier1=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];     
     
       
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        if(indexPath.section==0)
        {
        cell.textLabel.text=[archieve1 objectAtIndex:indexPath.row]; 
        cell.textLabel.highlightedTextColor=[UIColor magentaColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
        [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
        NSLog(@"Table view 3");
            return cell;
        }
        else if(indexPath.section==1)
        {
            cell.textLabel.text=[archieve2 objectAtIndex:indexPath.row];
            cell.textLabel.highlightedTextColor=[UIColor magentaColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
            [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
            return cell;
        } 
        else if(indexPath.section==2)
        {            
            cell.textLabel.text=[archieve3 objectAtIndex:indexPath.row];
            cell.textLabel.highlightedTextColor=[UIColor magentaColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
            [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
            return cell;

        }
    }    
    //tableview 4 and setting the array of items to tableview cell....
    else if(tableView==self.mytableview4)
    {
        static NSString *cellIdentifier1=@"Cell1";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        UserCreatingList *userobj=[[UserCreatingList alloc]initWithNibName:@"UserCreatingList" bundle:nil];
        newlist3=userobj.deletedListArray;
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        if(indexPath.section==0)
        {
            cell.textLabel.text=[newlist1 objectAtIndex:indexPath.row]; 
            cell.textLabel.highlightedTextColor=[UIColor magentaColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
            [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
            NSLog(@"Table view 4");
            return cell;
        }
        else if(indexPath.section==1)
        {
            cell.textLabel.text=[newlist2 objectAtIndex:indexPath.row];
            cell.textLabel.highlightedTextColor=[UIColor magentaColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
            [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
            return cell;
        }
        else if(indexPath.section==2)
        {
            cell.textLabel.text=[newlist3 objectAtIndex:indexPath.row];
            cell.textLabel.highlightedTextColor=[UIColor magentaColor];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"shopping.png"]];;
            [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
            return cell;
        }     
    }
   return 0;
}
#pragma mark-setting colors for the cell display...
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    if(tableView==self.myTableview)
    {
        //[cell setBackgroundColor:[UIColor colorWithRed:1 green:.2 blue:.4 alpha:1]];
    cell.backgroundColor = [self colorForIndex:indexPath.row];
    }
    else if(tableView==self.mytableview2)
    {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
    }
    else if(tableView==self.mytableview3)
    {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
    }
    else if(tableView==self.mytableview4)
    {
        cell.backgroundColor = [self colorForIndex:indexPath.row];
    }
}
-(UIColor*)colorForIndex:(NSInteger)index
{    
    CGFloat sr = 217.0/255.0, sg = 0.0, sb = 22.0/255.0;
    CGFloat er = 234.0/255.0, eg = 175.0/255.0 , eb = 28.0/255.0;    
    int cutoff = 7;
    CGFloat delta = 1.0 / cutoff;
    if ( count > cutoff )
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
#pragma mark-setting title for header section in tableview
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView==myTableview)
    {
        switch(section)
        {
            case 0:
                return @"GUIDELINES";
            default:
                return 0;
        }
    }
    else if(tableView==mytableview2)
    {
        switch(section)
        {
            case 0:
                return @"MENU";
            default:
                return 0;
        }
    }
    else if(tableView==mytableview3)
    {
        switch(section)
        {
            case 0:
                return @"Deleted From TableView1";
            case 1:
                return @"Deleted From TableView2";
            case 2:
                return @"Deleted From User List";
            default:
                return 0;
        }
    }
    else if(tableView==mytableview4)
    {
        switch(section)
        {
            case 0:
                return @"Completed From TableView1";
            case 1:
                return @"Completed From TableView2";
            case 2:
                return @"Completed From User List";
            default:
                return 0;
        }
    }
    return 0;
}
#pragma mark-doing some process when i select one particular cell....
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;   
    if([text isEqualToString:@"Move to Guidelines"])   
    {
        [mytableview2 setHidden:YES];
        [myTableview setHidden:NO];
        [UIView transitionWithView:myTableview duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^(void){
            [myTableview reloadData];
        }completion:NULL];
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
    }
    if([text isEqualToString:@"DELETED Items"])
    {
        [mytableview2 setHidden:YES];
        [mytableview3 setHidden:NO];      
         NSLog(@"Values in archieve 3 is %@",archieve3);
        [UIView transitionWithView:mytableview3 duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^(void){
            [mytableview3 reloadData];
        }completion:NULL];
        
        mytableview3.separatorColor=[UIColor blackColor];  
        mytableview3.backgroundColor=[UIColor blackColor]; 
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
    }
    if([text isEqualToString:@"Create User List"])
    {      
        UserCreatingList *userlistobject=[[UserCreatingList alloc]initWithNibName:@"UserCreatingList" bundle:Nil];    
        [userlistobject.userCreatedListTable setHidden:YES];       
        [self.navigationController pushViewController:userlistobject animated:YES];        
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
    }
    if([text isEqualToString:@"COMPLETED Items"])
    {
        [mytableview2 setHidden:YES];
        [mytableview3 setHidden:YES];
        [mytableview4 setHidden:NO];   
        UserCreatingList *userobj=[[UserCreatingList alloc]initWithNibName:@"UserCreatingList" bundle:nil];
        archieve3=userobj.completedListArray;
        [UIView transitionWithView:mytableview4 duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^(void){
            [mytableview4 reloadData];
        }completion:NULL];
        mytableview4.separatorColor=[UIColor blackColor];  
        mytableview4.backgroundColor=[UIColor blackColor]; 
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                       [NSURL fileURLWithPath:path] error:NULL];
        [audioplayer play];
    }
    if([text isEqualToString:@"Show AlarmTable"])
    {
        AlarmListController *alarmviewobj=[[AlarmListController alloc]initWithNibName:@"AlarmListController" bundle:nil];
        [self.navigationController pushViewController:alarmviewobj animated:YES];
    }
    
}
-(void)pinchGestureRecognizer:(UIPinchGestureRecognizer *)recognizer
{
    imageview.hidden=YES;
    sumtwoimage.hidden=YES;
    [myTableview setHidden:YES]; 
    [mytableview3 setHidden:YES];
    [mytableview4 setHidden:YES];  
    [UIView transitionWithView:mytableview2 duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [mytableview2 reloadData];
    }completion:NULL]; 
    [mytableview2 reloadData];
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"toy_duck_squeeze_out_water_version_4" ofType:@"mp3"];
    audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                   [NSURL fileURLWithPath:path] error:NULL];
    [audioplayer play];
    mytableview2.separatorColor=[UIColor blackColor];  
    [mytableview2 setHidden:NO];
    mytableview2.backgroundColor=[UIColor blackColor]; 
    NSLog(@"Hi this is long press gesture...");    
}
#pragma mark-longPress Gestures
- (IBAction)longPressGesture:(id)sender 
{    
     imageview.hidden=YES;
    sumtwoimage.hidden=YES;
    [myTableview setHidden:YES]; 
    [mytableview3 setHidden:YES];
    [mytableview4 setHidden:YES];  
    [UIView transitionWithView:mytableview2 duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [mytableview2 reloadData];
        }completion:NULL]; 
    [mytableview2 reloadData];
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"toy_duck_squeeze_out_water_version_4" ofType:@"mp3"];
    audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                   [NSURL fileURLWithPath:path] error:NULL];
    [audioplayer play];
    mytableview2.separatorColor=[UIColor blackColor];  
    [mytableview2 setHidden:NO];
    mytableview2.backgroundColor=[UIColor blackColor]; 
    NSLog(@"Hi this is long press gesture...");    
}
-(void)insertentries
{
    NSLog(@"Add Button");
    UserCreatingList *userlistobject=[[UserCreatingList alloc]initWithNibName:@"UserCreatingList" bundle:Nil];    
    [userlistobject.userCreatedListTable setHidden:YES];  
    [self.navigationController pushViewController:userlistobject animated:YES];        
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"human_whistling_using_fingers_in_mouth_to_gain_someone_s_attention" ofType:@"mp3"];
    audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                   [NSURL fileURLWithPath:path] error:NULL];
    [audioplayer play];
}
#pragma mark-Swipe Gestures for completing the cell
-(void)onSwipeRight:(UISwipeGestureRecognizer *)recognizer
{
    if([mytableview2 isHidden] )//&& [mytableview4 isHidden] && [mytableview3 isHidden ])
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGPoint swipeLocation = [recognizer locationInView:myTableview];
            NSIndexPath *swipedIndexPath = [myTableview indexPathForRowAtPoint:swipeLocation];
            UITableViewCell *swipedCell = [myTableview cellForRowAtIndexPath:swipedIndexPath];          
            [listof_Items removeObjectAtIndex:swipedIndexPath.row];
            [self.myTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSString *path = [[NSBundle mainBundle]
                              pathForResource:@"SoundsCrate-SciFi-PowerUp1" ofType:@"wav"];
            audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                           [NSURL fileURLWithPath:path] error:NULL];
            [audioplayer play];
            NSLog(@"Completing the items in tableview 1");             
            NSString *name=swipedCell.textLabel.text;            
            [newlist1 addObject:name];        
        }
    }
    else if([myTableview isHidden])
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGPoint swipeLocation = [recognizer locationInView:mytableview2];
            NSIndexPath *swipedIndexPath = [mytableview2 indexPathForRowAtPoint:swipeLocation];
            UITableViewCell *swipedCell = [mytableview2 cellForRowAtIndexPath:swipedIndexPath];
            [listof_Items1 removeObjectAtIndex:swipedIndexPath.row];
            [self.mytableview2 deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSString *path = [[NSBundle mainBundle]
                              pathForResource:@"SoundsCrate-SciFi-PowerUp1" ofType:@"wav"];
            audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                           [NSURL fileURLWithPath:path] error:NULL];
            [audioplayer play];
            NSLog(@"Completing the itemsn tableview 2");            
            NSString *name=swipedCell.textLabel.text;            
            [newlist2 addObject:name];        
        } 
    }
}
//Left Gestures for Deleting the Cell
- (void)onSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    if([mytableview2 isHidden])
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGPoint swipeLocation = [recognizer locationInView:myTableview];
            NSIndexPath *swipedIndexPath = [myTableview indexPathForRowAtPoint:swipeLocation];
            UITableViewCell *swipedCell = [myTableview cellForRowAtIndexPath:swipedIndexPath];          
            [listof_Items removeObjectAtIndex:swipedIndexPath.row];
            [self.myTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSString *path = [[NSBundle mainBundle]
                              pathForResource:@"SoundsCrate-SciFi-PowerDown3" ofType:@"wav"];
            audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                           [NSURL fileURLWithPath:path] error:NULL];
            [audioplayer play];
            NSLog(@"Deleting the items in tableview 1"); 
            
            NSString *name=swipedCell.textLabel.text;
                    
            [archieve1 addObject:name];        
            NSLog(@"Value of archieve is %@",archieve1);
        }
    }
    else if([myTableview isHidden])
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            CGPoint swipeLocation = [recognizer locationInView:mytableview2];
            NSIndexPath *swipedIndexPath = [mytableview2 indexPathForRowAtPoint:swipeLocation];
            UITableViewCell *swipedCell = [mytableview2 cellForRowAtIndexPath:swipedIndexPath];
            [listof_Items1 removeObjectAtIndex:swipedIndexPath.row];
            [self.mytableview2 deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSString *path = [[NSBundle mainBundle]
                              pathForResource:@"SoundsCrate-SciFi-PowerDown3" ofType:@"wav"];
            audioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                           [NSURL fileURLWithPath:path] error:NULL];
            [audioplayer play];
            NSLog(@"Deleting the itemsn tableview 2");            
            NSString *name=swipedCell.textLabel.text;            
            [archieve2 addObject:name];        
            NSLog(@"Value of archieve is %@",archieve2);        
        } 
    }
}
@end
