//
//  RegionalSettingViewController.m
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/09/30.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "RegionalSettingViewController.h"
#define MY_CITY @"東京都"
#define MY_TIME @"12:00"
@interface RegionalSettingViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;

@end

@implementation RegionalSettingViewController

@synthesize getCityName;
@synthesize getTimePicker;



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
    
    
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_settings_long.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // TextFieldのタグ付け
    getCityName.tag = 1;
    getTimePicker.tag = 2;
    
    
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    
    getCityName.text = [uds stringForKey:@"MY_CITY"];
    getTimePicker.text = [uds stringForKey:@"MY_TIME"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)inputCityName:(id)sender {
    
    // AppDelegateに渡すためのインスタンス宣言
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaultsCityName = [NSUserDefaults standardUserDefaults];
    [userDefaultsCityName setObject:getCityName.text forKey:@"MY_CITY"];
    [userDefaultsCityName synchronize];
    
    appDelegate.delegateCityName = getCityName.text;
   
    NSLog(@"stringCityName : %@",self.getCityName.text);
}

- (IBAction)inputTime:(id)sender {
    
    // openDatePickerViewの呼び出し
    [self openDatePickerView:sender];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // returnKeyをタッチしたらKeyBoardを閉じる
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // KeyBoard外をタッチしたらKeyBoardを閉じる
    [self.view endEditing:YES];
}

// KeyBoardの呼び出しメソッド
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    // KeyBoard or datePickerの呼び出し判定
    if (textField.tag == 1)
        return YES;
    else
        return NO;
}


// datePickerViewの呼び出しメソッド
- (void)openDatePickerView:(id)sender {
    
    
    self.datePickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DatePickerViewController"];
    
    self.datePickerViewController.delegate = self;
    
    
    // datePickerをサブビューとしてゆっくり表示する
    UIView *datePickerView = self.datePickerViewController.view;
    CGPoint middleCenter = datePickerView.center;
    
    // datePickerのアニメーション設定
    UIWindow* mainWindow = (([UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    datePickerView.center = offScreenCenter;
    
    [mainWindow addSubview:datePickerView];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    datePickerView.center = middleCenter;
    [UIView commitAnimations];
}

// datePickerViewを閉じるメソッド
- (void)closePickerView:(DatePickerViewController *)controller {
    
    // datePickerをアニメーションを使ってゆっくり閉じる
    UIView *pickerView = controller.view;
    
    // datePickerのアニメーション設定
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];

    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
    
}

// PickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}

- (void)pickerSelectedString:(NSString *)str {
    self.getTimePicker.text = str;
    
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaultsTimePicker = [NSUserDefaults standardUserDefaults];
    [userDefaultsTimePicker setObject:getTimePicker.text forKey:@"MY_TIME"];
    [userDefaultsTimePicker synchronize];
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
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
