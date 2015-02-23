//
//  UserCreatingList.h
//  ColorForCell
//
//  Created by Admin on 07/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@class AppDelegate;
@interface UserCreatingList : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    AVAudioPlayer *audioplayer;
    int count;   
    AppDelegate *delegateObj;
 
}
@property (strong, nonatomic) IBOutlet UITableView *userCreatedListTable;
@property (weak, nonatomic) IBOutlet UITableView *deletedTableview;
@property (weak, nonatomic) IBOutlet UITableView *completedTableview;
@property(strong,nonatomic)NSMutableArray * newlist,*deletedListArray,*completedListArray;

-(UIColor*)colorForIndex:(NSInteger) index;
@end


