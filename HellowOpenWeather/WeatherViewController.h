//
//  WeatherViewController.h
//  HellowWorld
//
//  Created by Satoshi_Hirazawa on 2014/09/13.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWMWeatherAPI.h"



@interface WeatherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *ConditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *RainfallLabel;
@property (weak, nonatomic) IBOutlet UILabel *CloudCoverageLabel;

@end
