//
//  AppDelegate.h
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/09/23.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (copy, nonatomic) NSString *delegateCityName;
@property (copy, nonatomic) NSString *delegateTimePicker;
@property (copy, nonatomic) NSString *delegateMyKonashiName;

@property BOOL *delegateAutoFindFlg;

@property (nonatomic) CLLocationCoordinate2D delegateCoordinate;
@property (strong, nonatomic) UIWindow *window;


@end
