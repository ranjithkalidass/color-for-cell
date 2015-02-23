//
//  ViewController.h
//  ColorForCell
//
//  Created by Admin on 03/01/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@class AppDelegate;
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *listof_Items,*listof_Items1,*archieve1,*archieve2,*archieve3,*newlist1,*newlist2;
    CGPoint _originalCenter;
	BOOL _deleteOnDragRelease;
    int count;
    NSString *check;
    AVAudioPlayer *audioplayer;
    AppDelegate *delegateobj;
    UIImageView *imageview,*sumtwoimage;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UITableView *mytableview2;
@property (weak, nonatomic) IBOutlet UITableView *mytableview3;
@property (weak, nonatomic) IBOutlet UITableView *mytableview4;
@property (strong, nonatomic) IBOutlet UITextView *companynameText;

@property(strong,nonatomic)NSMutableArray *archieve3,*newlist3;
- (IBAction)swipeAction:(id)sender;
- (IBAction)longPressGesture:(id)sender;
-(UIColor*)colorForIndex:(NSInteger) index;

@end
