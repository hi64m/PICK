//
//  DatePickerViewController.h
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/10/07.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@protocol DatePickerViewControllerDelegate;

@interface DatePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) id<DatePickerViewControllerDelegate> delegate;

- (IBAction)closePicker:(id)sender;

@end


@protocol DatePickerViewControllerDelegate <NSObject>

-(void)pickerSelectedString:(NSString *)str;
-(void)closePickerView:(DatePickerViewController *)controller;

@end