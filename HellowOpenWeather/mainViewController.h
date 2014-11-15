//
//  mainViewController.h
//  tabtest
//
//  Created by Satoshi_Hirazawa on 2014/09/25.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "OWMWeatherAPI.h"
#import "RegionalSettingViewController.h"

#define NEAR_THRESHOLD 60
#define FAR_THRESHOLD 80
#define NUMBER_OF_BLINK 4
#define PERIOD_OF_BLINK 2

@interface mainViewController : UIViewController
<UIBarPositioningDelegate>

- (IBAction)GetWeatherData:(id)sender;
- (IBAction)debugButton:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationItem *mainTitile;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *konashiRSSI;

@property (nonatomic) SystemSoundID rainFall;
@property (nonatomic) SystemSoundID leftBehind;

@property BOOL rainFlag;
@property BOOL weatherRequestFlag;
@property BOOL rainDebug;
@property BOOL findFlag;

@property (nonatomic, strong) NSTimer *blinkTimer;
@property (nonatomic, strong) NSTimer *rssiTimer;
@property (nonatomic, strong) NSTimer *findKonashiTimer;


@property (nonatomic, strong) NSString *timePicker;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *myKonashi;

@property (nonatomic) NSInteger blinkCount;
@property (nonatomic) NSInteger rssi;


@property (nonatomic) CLLocationCoordinate2D byCoordinate;



@end



