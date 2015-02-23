//
//  CreateAlarmController.h
//  ColorForCell
//
//  Created by Admin on 15/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAlarmController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *showTimeText;
@property (strong, nonatomic) IBOutlet UITextField *customTextField;
@property(strong,nonatomic) NSArray *localNotifications;
- (IBAction)changeinPicker:(id)sender;

@end
