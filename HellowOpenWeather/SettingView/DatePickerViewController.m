//
//  DatePickerViewController.m
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/10/07.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "DatePickerViewController.h"
#define MY_TIME @"12:00"
@interface DatePickerViewController ()
@property (nonatomic, strong) NSString *timePicker;
@end

@implementation DatePickerViewController

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
    // Do any additional setup after loading the view.
    
    // 背景を透明にする
    UIColor *alphaColor = [self.view.backgroundColor colorWithAlphaComponent:0.0];
    self.view.backgroundColor = alphaColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate closePickerView:self];
    [self setTimePicker];
}

- (IBAction)closePicker:(id)sender {
    [self.delegate closePickerView:self];
    [self setTimePicker];
}

- (void)setTimePicker{

    // AppDelegateに渡すためのインスタンス宣言
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // DateFormatterの指定
    NSDateFormatter *dFormat = [[NSDateFormatter alloc]init];
    dFormat.dateFormat = @"HH:mm";
    
    // _datePicker.dateをDateFormatterに当てて_timePickerに代入
    _timePicker = [dFormat stringFromDate:_datePicker.date];
    
    // timePickerをtextFieldに表示
    [self.delegate pickerSelectedString:_timePicker];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 時刻の取得
    flags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    comps = [calendar components:flags fromDate:_datePicker.date];
    
    // 時刻の調整
    int rest = comps.hour % 3;
    if (rest) {
        comps.hour  = comps.hour - rest;
    }
    comps.minute = 0;
    
    // NSDateComponents → NSDate
    NSDate* dtComp = [calendar dateFromComponents:comps];
    
    
    // dtCompをDateFormatterに当てて_timePickerに代入
    _timePicker = [dFormat stringFromDate:dtComp];
    
    // AppDelegateにTimePickerを渡す
    appDelegate.delegateTimePicker = _timePicker;
    

    
    NSLog(@"stringTime : %@", _timePicker);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
