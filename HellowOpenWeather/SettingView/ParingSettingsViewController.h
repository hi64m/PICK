//
//  ParingSettingsViewController.h
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/09/30.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "AppDelegate.h"


NSUserDefaults *userMyKonashi;

@interface ParingSettingsViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>


@property (strong, nonatomic) CBCentralManager *cbManager;
@property (strong, nonatomic) CBPeripheral *connectedPeripheral;


- (IBAction)find:(id)sender;

@end
