//
//  RegionalSettingViewController.h
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/09/30.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "DatePickerViewController.h"

@interface RegionalSettingViewController : UIViewController <DatePickerViewControllerDelegate, UIBarPositioningDelegate>
@property (nonatomic, strong) NSArray *settingMenu;
@property (weak, nonatomic) IBOutlet UITextField *getCityName;
@property (weak, nonatomic) IBOutlet UITextField *getTimePicker;

@property (strong, nonatomic) DatePickerViewController *datePickerViewController;

- (IBAction)inputCityName:(id)sender;
- (IBAction)inputTime:(id)sender;

@end
