
//
//  PopUpViewController.m
//  KptTime
//
//  Created by matsu on 2016/04/20.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

- (IBAction)close:(id)sender;

@end

@implementation PopUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender
{
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.view.alpha = 0.2f;
                     }
                     completion:^(BOOL finished){
                         [self.view removeFromSuperview];
                         self.view.alpha = 1.f;
                     }];
}

@end

