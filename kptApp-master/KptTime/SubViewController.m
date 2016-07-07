//
//  SubViewController.m
//  KptTime
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

//
//  SubViewControler.m
//  KptTimer
//
//  Created by matsu on 2016/04/13.
//  Copyright © 2016年 testdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewController.h"
#import "AppDelegate.h"


@interface SubViewController () {
    //    int countTime;
}

@property (nonatomic) NSArray *data; //dataArray
@property (nonatomic) NSArray *allocationTime;
@property NSTimer *timer; //クイズ中の経過時間を生成する
@property int countTime;  //設定時間
@property (nonatomic) NSMutableArray *sectionTitle;

@property int num;
@property NSString* countDown;
@property int timeData;
@property int num2;
@property int annonncementTime;
@property int thinkingTime;
@property int s;
@property int a;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"thinking   ",@"annonncement   "];
    self.allocationTime = @[@3,@10];
    self.timeMArray = [[NSMutableArray alloc]init];
    self.sectionTitle = [[NSMutableArray alloc]init];
    self.num = -1;
    self.thinkingTime = 3;
    self.cellN3 = 0;
    //    self.s = 0;
    //    self.a = 0;

    //    １列目cell
    int fValue = [[self.allocationTime objectAtIndex:0] intValue];
    
    //    ２列目cell
    int fValue2 = [[self.allocationTime objectAtIndex:1] intValue];
    self.num2 = fValue;
    self.num = 0;
    
    fValue2 = [self.svStr intValue];
    int annonncementTime = (fValue2 - 9)/4;
    
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:self.thinkingTime] atIndex:0];
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:annonncementTime] atIndex:1];
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:self.thinkingTime] atIndex:2];
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:annonncementTime] atIndex:3];
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:self.thinkingTime] atIndex:4];
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:annonncementTime] atIndex:5];
    
    float fOver = (fValue2 - 9)%4;
    int todoTime = fOver + annonncementTime;
    [self.timeMArray insertObject:[[NSNumber alloc] initWithInt:todoTime] atIndex:6];
    
    for(int i=0; i < self.timeMArray.count; i++){
        NSLog(@"timeMArray[i]--%@",self.timeMArray[i]);
        
        self.popUpViewController = [[PopUpViewController alloc] init];
        [self addChildViewController:self.popUpViewController];
        [self.popUpViewController didMoveToParentViewController:self];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    //    self.tableView.dataSource = self;
    //    self.tableView.delegate = self;
    if(self.svEditField !=nil){
        NSString *nu = self.svEditField;
        int edField = [nu intValue];
        
        int n = (int)self.cellN3;
        int timeVal = [[self.timeMArray objectAtIndex:(int)self.cellN3]intValue];
        int difference = timeVal - edField;
        
        int todoTime = [[self.timeMArray objectAtIndex:6]intValue];
        
        todoTime += difference;
        if(edField >= 0  && todoTime > 0 ){
            NSNumber *number = [NSNumber numberWithInt:edField];
            NSString *str = [[NSString alloc] initWithFormat:@"%d",todoTime];
            self.timeMArray[n] = number;
            self.timeMArray[6] = str;
        }
    }
    for(int i=0; i < self.timeMArray.count; i++){
        NSLog(@"timeMArray[i]--%@",self.timeMArray[i]);
    }
    self.num = 0;
    self.tableView.scrollEnabled = false;
    [self.tableView reloadData];
    //    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    //    [self.tableView reloadData];
    //    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section < 3) {
        return self.data.count; //セクションのセルは2個とします
    }
    return 1; // セクションのセルは1個とします
}


//表示するセル
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    セルのID指定
    static NSString *cellID = @"cell"; //cellBook
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //    新規セルの判定
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSLog(@"self.num%d",self.num);
    //    １列目cell
    NSString *str = [self.data objectAtIndex:0];
    //    ２列目cell
    NSString *str2 = [self.data objectAtIndex:1];
    
    if(indexPath.section < 3){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text= [NSString stringWithFormat:@"%@%@m",str,self.timeMArray[self.num]];
            break;
        case 1:
            cell.textLabel.text= [NSString stringWithFormat:@"%@%@m",str2,self.timeMArray[self.num]];
            break;
        default:
            cell.textLabel.text = @"それ以外のセル";
            break;
    }
    self.num++;
    //    NSString *sectionName = [self.se objectAtIndex:indexPath.section];
    
    return cell;
}


// 編集画面へ移動する
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.timer invalidate];
    [self.popUpViewController.view removeFromSuperview];
    ThirdViewController *thirdView = [self.storyboard instantiateViewControllerWithIdentifier:@"tvc"];
    switch (indexPath.row) {
        case 0:
            thirdView.cellName = @"thinking";
            switch (indexPath.section) {
                case 0:
                    self.cellN3 = 0;
                    break;
                case 1:
                    self.cellN3 = 2;
                    break;
                case 2:
                    self.cellN3 = 4;
                    break;
                default:
                    break;
            }
            break;
        case 1:
            thirdView.cellName = @"annonncement";
            switch (indexPath.section) {
                case 0:
                    self.cellN3 = 1;
                    break;
                case 1:
                    self.cellN3 = 3;
                    break;
                case 2:
                    self.cellN3 = 5;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    //    self.cellN = indexPath.row;
    //    self.sectionNum = indexPath.section;
    
    //     thirdView.timeEdit = [self.timeMArray objectAtIndex:self.cellN3];
    thirdView.timeEdit = (NSNumber *)self.timeMArray[self.cellN3];
    thirdView.labelEdit = [self.sectionTitle objectAtIndex:indexPath.section];
    
    //NSLog(@"ndexPath.section---%@",[self.sectionTitle objectAtIndex:indexPath.section]);
    if(indexPath.section < 3){
        // 値を異なるビューへ渡す
        [self.navigationController pushViewController:thirdView animated:YES];
    }
    
}


// TableViewに表示するグルーピングの数を指定する。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


// 各グループの表示用名称を返却する。
// 今回はセクション数を含んだ文字列をグループタイトルとして表示する。
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            [self.sectionTitle addObject:@"Keep"];
            return @"Keep";
        case 1:
            [self.sectionTitle addObject:@"Problem"];
            return @"Problem";
        case 2:
            [self.sectionTitle addObject:@"Try"];
            return @"Try";
        case 3:
            return @"Todo";
        default:
            return @"";
    }
}

//sectionの色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if(section < 3){
        [view setTintColor:[UIColor orangeColor]];
    }
    else if(section == 3){
        [view setTintColor:[UIColor greenColor]];
    }
}


- (IBAction)startButton:(UIButton *)sender {
    [self startAction];
    //id型のsenderをUIButton型に変換する
    UIButton *senderBtn = (UIButton *)sender;
    
    //タイトルにより分岐（文字列なのでswitch文は使えない）
    if ([senderBtn.currentTitle isEqualToString: @"stop"]) {
        //タイトルを変更
        [senderBtn setTitle:@"start" forState:UIControlStateNormal];
        
        //何らかの処理
        [self stop];
        
    }else{
        //タイトルを戻す
        [senderBtn setTitle:@"stop" forState:UIControlStateNormal];
        
        //何らかの処理
        
    }
}

- (IBAction)stop {
    //タイマーが動いているときにタイマー停止
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}


//- (void)startAction:(NSInteger *)intData{
- (void)startAction{
    //    self.popUpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tvc"];
    
    self.popUpViewController.view.center = self.view.center;
    
    [self.view addSubview:self.popUpViewController.view];
    CGPoint center = self.popUpViewController.contentView.center;
    UIView* view = self.popUpViewController.contentView;
    
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5f,0.5f);
    view.center = center;
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformIdentity;
                         view.center = center;
                     }
                     completion:nil];
    
    if (![self.timer isValid]) {
        self.timer = [NSTimer
                      scheduledTimerWithTimeInterval:1
                      target: self
                      selector:@selector(timerAction)
                      userInfo:nil
                      repeats:YES];
        
        _countTime = [[self.timeMArray objectAtIndex:self.timeData]intValue];
        //                NSLog(@"countTime---%d",_countTime);
        //        _countTime *= 60;
        [self.timer fire];
        self.countDown = [NSString stringWithFormat:@"%d",_countTime]; //カウントダウン
    }else{
        
    }
}


- (void)timerAction{
    
    if (_countTime <= 0.0 && [self.timer isValid]){
        self.a++;
        NSLog(@"---stop--timeData%d-",self.timeData);
        AudioServicesPlaySystemSound(1000);
        [self.timer invalidate];
        [self.popUpViewController.view removeFromSuperview];
        //        [self startAction:self.timeData++];
        self.timeData++;
        if(self.timeData < 7){
            [self startAction];
        }
    }
    else {
        NSLog(@"countTime--%d-countDown-",_countTime);
        self.popUpViewController.residueTimeLabel.text = [NSString stringWithFormat:@"%d", _countTime];
        switch (self.a) {
            case 0:
                self.popUpViewController.titleLabel.text = @"Keep";
                self.popUpViewController.titleLabel2.text = self.data[0];
                break;
            case 1:
                self.popUpViewController.titleLabel.text = @"Keep";
                self.popUpViewController.titleLabel2.text = self.data[1];
                break;
            case 2:
                self.popUpViewController.titleLabel.text = @"Problem";
                self.popUpViewController.titleLabel2.text = self.data[0];
                break;
            case 3:
                self.popUpViewController.titleLabel.text = @"Problem";
                self.popUpViewController.titleLabel2.text = self.data[1];
                break;
            case 4:
                self.popUpViewController.titleLabel.text = @"Try";
                self.popUpViewController.titleLabel2.text = self.data[0];
                break;
            case 5:
                self.popUpViewController.titleLabel.text = @"Try";
                self.popUpViewController.titleLabel2.text = self.data[1];
                break;
            case 6:
                self.popUpViewController.titleLabel.text = @"Todo";
                self.popUpViewController.titleLabel2.text = self.data[0];
                break;
            default:
                break;
        }
        _countTime--;
    }

}

@end