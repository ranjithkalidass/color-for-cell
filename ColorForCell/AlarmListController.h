//
//  AlarmListController.h
//  ColorForCell
//
//  Created by Admin on 15/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AlarmListController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    NSMutableArray *deletedarray;
    NSMutableArray *completedarray;
    NSMutableArray *newlist;
    AVAudioPlayer *audioplayer; 
    UIActionSheet *actionsheet,*actionsheetcompleted;
}
@property (strong, nonatomic) IBOutlet UITableView *alarmListTable;
@property (strong, nonatomic) IBOutlet UITableView *deletedNotificationTable;
@property (strong, nonatomic) IBOutlet UITableView *completedNotificationTable;

@end
