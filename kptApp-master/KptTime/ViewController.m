//
//  ViewController.m
//  KptTime
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
//+ (BOOL)chkNumeric:(NSString *)checkString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeInput.keyboardType = UIKeyboardTypeNumberPad;
    
//    countdown_timer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                       target:self
//                                                     selector:@selector(update)
//                                                     userInfo:nil
//                                                      repeats:YES];
//    time = 30;
//    [countdown_timer fire];
//    NSLog(@"%@",[NSString stringWithFormat:@"%d",time]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField*)txField{
    [self.timeInput resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // ここにtextデータの処理

    // キーボードを閉じる
    [self.timeInput resignFirstResponder];
}
//- (void)update{
//    if (time <= 0.0) {
//        [countdown_timer invalidate];
//    }
//    else {
//        time--;
//    }
//}



// 数字のみか （引数は文字列なので注意）
//+ (BOOL)chkNumeric:(NSString *)checkString{
//    //    @autoreleasepool
//    //    {
//    NSCharacterSet *digitCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    bool ret = [self chkCompareString:checkString baseString:digitCharSet];
//    return ret;
//    //    }
//}
//
//
//+ (BOOL)chkCompareString:(NSString *)checkString baseString:(NSCharacterSet *)baseStrin{
//    @autoreleasepool{
//        NSScanner *aScanner = [NSScanner localizedScannerWithString:checkString];
//        // NSScannerはﾃﾞﾌｫﾙﾄでは前後のｽﾍﾟｰｽなどを読み飛ばしてくれるのだが､あえて-setCharactersToBeSkipped:でnilを渡して抑制している｡
//        [aScanner setCharactersToBeSkipped:nil];
//        [aScanner scanCharactersFromSet:baseStrin intoString:NULL];
//        return [aScanner isAtEnd];
//    }
//}



- (IBAction)CalcButton:(UIButton *)sender {
    if ((self.timeInput.text != nil) && (![self.timeInput.text  isEqual: @""]) ) {
        //空文字ではない
        if (![self isNumber:self.timeInput.text]) {
            //数値以外
            NSLog(@"-- 数値以外　--s");
        }else{
            SubViewController *subView = [self.storyboard instantiateViewControllerWithIdentifier:@"svc"];
            subView.svStr = self.timeInput.text;
            // 値を異なるビューへ渡す
            [self.navigationController pushViewController:subView animated:YES];
        }
    }
}


- (BOOL)isNumber:(NSString *)value {
    // 空文字の場合はNO
    if ( (value == nil) || ([@"" isEqualToString:value]) ) {
        return NO;
    }
    NSInteger l = value.length;
    BOOL b = NO;
    for (int i = 0; i < l; i++) {
        NSString *str =
        [[value substringFromIndex:i]
         substringToIndex:1];
        
        const char *c =
        [str cStringUsingEncoding:
         NSASCIIStringEncoding];
        
        if ( c == NULL ) {
            b = NO;
            break;
        }
        
        if ((c[0] >= 0x30) && (c[0] <= 0x39)) {
            b = YES;
        } else {
            b = NO;
            break;
        }
    }
    
    if (b) {
        return YES;  // 数値文字列である
    } else {
        return NO;
    }
}



@end
