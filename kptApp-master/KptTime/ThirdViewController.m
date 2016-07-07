//
//  ThirdViewController.m
//  KptTime
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThirdViewController.h"

@interface ThirdViewController ()
//@property IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *data; //dataArray
@property (weak, nonatomic) IBOutlet UILabel *labelName;
- (IBAction)editOkButton:(UIButton *)sender;

@end

@implementation ThirdViewController
   @synthesize sVC = _sVC;

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES];
    
    self.editTimeValue.keyboardType = UIKeyboardTypeNumberPad;
    self.editTimeValue.text = [self.timeEdit stringValue]; //textF
    self.editText.text = self.labelEdit; //タイトル名
    self.labelName.text = self.cellName; //thinking,annonncement 名前
//    int todoTime = [[svc.timeMArray objectAtIndex:6]intValue];
//    NSLog(@"%@",[sv.timeMArray objectAtIndex:6]);
}


// 戻るボタンが押された処理
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSArray *array=self.navigationController.viewControllers;
    int arrayCount = (int)[array count];
    SubViewController *svc = [array objectAtIndex:arrayCount-1];
    svc.svEditField = self.editTimeValue.text;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)editOkButton:(UIButton *)sender {
    // コントローラを生成
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@"エラー"
                                        message:@"数値を入力してください。"
                                 preferredStyle:UIAlertControllerStyleAlert];
   
    ViewController * vc = [[ViewController alloc]init];
    if ((self.editTimeValue.text != nil) && (![self.editTimeValue.text  isEqual: @""]) ) {
        //空文字ではない
        
        if (![vc isNumber:self.editTimeValue.text ]) {
            //数値以外

            // Cancel用のアクションを生成
         
            UIAlertAction * cancelAction =
            [UIAlertAction actionWithTitle:@"OK"
                                     style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * action) {
                                       // ボタンタップ時の処理
                                       NSLog(@"Cancel button tapped.");
                                       
                                   }];
            
            [ac addAction:cancelAction];

            
            // アラート表示処理
            [self presentViewController:ac animated:YES completion:nil];
        
        }else{
            NSLog(@"---editOkButton--");
        
            // 値を異なるビューへ渡す
             [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
         NSLog(@"---空文字--");
        UIAlertAction * cancelAction =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {
                                   // ボタンタップ時の処理
                                   NSLog(@"Cancel button tapped.");
                                   
                               }];
        
        [ac addAction:cancelAction];
        
        
        // アラート表示処理
        [self presentViewController:ac animated:YES completion:nil];
    }
    
   
}
@end