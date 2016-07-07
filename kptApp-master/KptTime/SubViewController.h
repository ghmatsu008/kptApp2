//
//  SubViewController.h
//  KptTime
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "PopUpViewController.h"

@interface SubViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property IBOutlet UITableView *tableView;
@property(nonatomic,copy) NSString *svStr;
@property(nonatomic,copy) NSString *svEditField;
@property NSInteger *cellN;
@property int cellN3;
@property NSInteger *sectionNum;
@property (nonatomic) NSMutableArray *timeMArray;
@property int thinkingValue;
@property(nonatomic, strong) PopUpViewController* popUpViewController;

- (IBAction)startButton:(UIButton *)sender;
- (void)timerAction;
- (void)startAction;

@end
