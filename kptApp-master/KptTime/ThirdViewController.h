//
//  ThirdViewController.h
//  KptTime
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SubViewController.h"
@class SubViewController;

@interface ThirdViewController : UIViewController
@property (nonatomic,retain) SubViewController *sVC;
@property (nonatomic) NSNumber *timeEdit;
@property (nonatomic) NSString *cellName;
@property (nonatomic) NSString *labelEdit;
@property (weak, nonatomic) IBOutlet UITextField *editTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *editText;
@property NSInteger *cellN2;
@property NSInteger *sectionNum2;
@end

