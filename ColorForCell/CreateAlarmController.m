//
//  CreateAlarmController.m
//  ColorForCell
//
//  Created by Admin on 15/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "CreateAlarmController.h"
#import "UserCreatingList.h"

@implementation CreateAlarmController
@synthesize customTextField;
@synthesize showTimeText;
@synthesize datePicker;
@synthesize localNotifications;

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
    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(insertentries)];
    self.navigationItem.rightBarButtonItem=add;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setShowTimeText:nil];
    [self setCustomTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark-Scheduling LocalNotifications...
-(void)insertentries
{
    NSDate *pickerDate = [self.datePicker date];
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    NSLog(@"%@",showTimeText.text);
    localNotification.alertBody=customTextField.text;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = 1;    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    NSLog(@"%@",localNotification.alertBody);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Saved" message:@"Successfully Saved" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Move To Menu", nil];
    [alert show];
    localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@",localNotifications);
}
#pragma mark-AlertView Delegate Functions
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        customTextField.text=@"";
        showTimeText.text=@"";       
    }
    else if(buttonIndex==1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark-Change in DatePickerView
- (IBAction)changeinPicker:(id)sender 
{
    NSDateFormatter *formatter;
    NSString *dateString;    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy hh:mm:ss"];    
    dateString = [formatter stringFromDate:[self.datePicker date]];
    showTimeText.text=dateString;
}

@end
