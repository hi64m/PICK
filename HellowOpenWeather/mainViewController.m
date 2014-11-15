//
//  mainViewController.m
//  tabtest
//
//  Created by Satoshi_Hirazawa on 2014/09/25.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "mainViewController.h"
#import "AppDelegate.h"

#import "Konashi.h"

#define MY_MAIN_KONASHI @"No konashi"
#define FIND_FLAG @"null"
#define ADDZERO @"0"
#define MY_MAIN_TIME @"12:00"
#define MY_MAIN_CITY @"東京都"

@interface mainViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation mainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *mainUD = [NSUserDefaults standardUserDefaults];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    _cityName = [mainUD stringForKey:@"MY_MAIN_CITY"];
    
    if (appDelegate.delegateCityName)
        _cityName = appDelegate.delegateCityName;
    // UserDefaults に TextFieldの値を保存
    [mainUD setObject:_cityName forKey:@"MY_MAIN_CITY"];
    
    _mainTitile.title = _cityName;
    
    // getCityNameからLocationを取得
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.cityName completionHandler:^(NSArray* placemarks, NSError* error) {
        
        for (CLPlacemark* placemark in placemarks) {
            // AppDelegateにLocationを渡す
            _byCoordinate = placemark.location.coordinate;
        }
    }];
    

    
    _timePicker = [[NSUserDefaults standardUserDefaults] valueForKey:@"MY_MAIN_TIME"];
    
    if (![_timePicker isEqualToString: appDelegate.delegateTimePicker] && appDelegate.delegateTimePicker != nil)
        _timePicker = appDelegate.delegateTimePicker;
    // UserDefaults に TextFieldの値を保存
    
    [mainUD setObject:_timePicker forKey:@"MY_MAIN_TIME"];
    
    
    _myKonashi = appDelegate.delegateMyKonashiName;
    if(_myKonashi  != nil )
        [mainUD setObject:_myKonashi forKey:@"MY_MAIN_KONASHI"];
    _myKonashi = [mainUD stringForKey:@"MY_MAIN_KONASHI"];
    
    if([Konashi isConnected] == 0){
        [self findKonashiTimerCall];
    }
    [mainUD synchronize];
}


- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _weatherIcon.image = [UIImage imageNamed: @"bg_wether_sunny.png"];
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(ready) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(strength) name:KONASHI_EVENT_UPDATE_SIGNAL_STRENGTH];
    [Konashi addObserver:self selector:@selector(connected) name:KONASHI_EVENT_CONNECTED];
    [Konashi addObserver:self selector:@selector(disconnected) name:KONASHI_EVENT_DISCONNECTED];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ready{
    [Konashi pinMode:LED2 mode:OUTPUT];
    [Konashi pinMode:PIO2 mode:OUTPUT];
    [self rssiTimerCall];
    NSLog(@"ready");
}

- (void)connected {
    NSLog(@"connected : %@" , [Konashi peripheralName]);
    [_findKonashiTimer invalidate];
    _findKonashiTimer = nil;
}

- (void)disconnected {
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"disconnected");
    [_rssiTimer invalidate];
    _rssiTimer = nil;
    [Konashi disconnect];
    
    NSUserDefaults *mainUD = [NSUserDefaults standardUserDefaults];
    _myKonashi = [mainUD stringForKey:@"MY_MAIN_KONASHI"];
    
    if([Konashi isConnected] == 0){
        [self findKonashiTimerCall];
    }
    
}



- (void) strength {
    _konashiRSSI.text = [NSString stringWithFormat:@"%d", [Konashi signalStrengthRead]];
    _rssi = [Konashi signalStrengthRead];
    NSLog(@"READ_STRENGTH: %d", self.rssi);
    [self requestWeatherData];
}



- (void) requestWeatherData{
    
    if(_rssi > -NEAR_THRESHOLD){
        
        if(!_weatherRequestFlag){
            
            OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"66296073b9af3a7f3b24f5db03117c85"];
            
            
            NSLog(@"latitude : %f", _byCoordinate.latitude);
            NSLog(@"longitude : %f", _byCoordinate.longitude);
            
            
            // 現在の日付を取得
            NSDate *getNow = [NSDate date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger flags;
            NSDateComponents *comps;
            
            // 年・月・日を取得
            flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
            comps = [calendar components:flags fromDate:getNow];
            
            NSString *year = [NSString stringWithFormat:@"%ld", (long)comps.year];
            NSString *month = [NSString stringWithFormat:@"%ld", (long)comps.month];
            NSString *day = [NSString stringWithFormat:@"%ld", (long)comps.day];
            
            
            if (month.length == 1)
                month = [ADDZERO stringByAppendingFormat:@"%@", month];
            if (day.length == 1)
                day = [ADDZERO stringByAppendingFormat:@"%@", day];
            
            NSString *getRequestTime = [NSString stringWithFormat:@"%@-%@-%@ %@:00", year, month, day, _timePicker];
            
            NSLog(@"getTime : %@",getRequestTime);
            
            [weatherAPI setTemperatureFormat:kOWMTempCelcius];
            
            [weatherAPI forecastWeatherByCoordinate:_byCoordinate withCallback:^(NSError *error, NSDictionary *result) {
                //    [weatherAPI forecastWeatherByCityName:byCityName withCallback:^(NSError *error, NSDictionary *result) {
                if (error) {
                    // handle the error
                    NSLog(@"API Request Error");
                    return;
                }
                
                // The data is ready
                // 「雨が降れば」という条件で降水量1mm以上で判定
                NSString *cityName = result[@"city"][@"name"];
                NSString *cityId = result[@"city"][@"id"];
                NSNumber *coordLat = result[@"city"][@"coord"][@"lat"];
                NSNumber *coordLon = result[@"city"][@"coord"][@"lon"];
                NSNumber *count = result[@"cnt"];
                NSDictionary *dataList = result[@"list"];
                
                NSLog(@"==========================================");
                
                NSLog(@"cityName : %@",cityName);
                NSLog(@"cityId : %@",cityId);
                NSLog(@"coordLat : %@",coordLat);
                NSLog(@"coordLon : %@",coordLon);
                NSLog(@"cnt : %@",count);
                
                NSLog(@"==========================================");
                
                
                NSInteger intCount = count.integerValue;
                NSString *dataDTtxtArr[intCount];
                NSString *weatherConditionArr[intCount];
                int i = 0;
                
                for (NSDictionary *listNum in dataList) {
                    
//                    NSLog(@"Counter                : %d", i);
                    
                    dataDTtxtArr[i] = [listNum objectForKey:@"dt_txt"];
//                    NSLog(@"Data receiving time Arr: %@", dataDTtxtArr[i]);
                    
                    
                    NSDictionary *dataWeather = [listNum objectForKey:@"weather"];
                    
                    for (NSDictionary *weatherNum in dataWeather) {
                        
                        weatherConditionArr[i] = [weatherNum objectForKey:@"main"];
                        
                        if(_rainDebug){
                            weatherConditionArr[i] = @"Rain";
                        }
                        
//                        NSLog(@"Weather condition Arr  : %@", weatherConditionArr[i]);
                        
                        NSString *weatherDescription = [weatherNum objectForKey:@"description"];
//                        NSLog(@"Weather description    : %@", weatherDescription);
                        
                    }
                    
                    NSDictionary *dataRain = [listNum objectForKey:@"rain"];
                    NSNumber *precipitationRain = [dataRain objectForKey:@"3h"];
//                    NSLog(@"Precipitation volume   : %@ mm", precipitationRain);
                    
 
                    
                    if ([weatherConditionArr[i]  isEqual: @"Rain"] && [dataDTtxtArr[i] isEqualToString: getRequestTime]){
                        _weatherIcon.image = [UIImage imageNamed: @"bg_wether_rainy.png"];   // 雨アイコンの表示
                        _rainFlag = true;
                        NSLog(@"rain!!");
                    }
                    else if(![weatherConditionArr[i]  isEqual: @"Rain"] && [dataDTtxtArr[i] isEqualToString: getRequestTime]){
                        _weatherIcon.image = [UIImage imageNamed: @"bg_wether_sunny.png"];    // 晴れアイコンの表示
                        _rainFlag = false;
                    }
                    
                    i++;
                }
                
                
                if (self.rainFlag) {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    [self blinkTimerCall];
                }
                else if(!self.rainFlag){
                    [self blinkTimerCall];
                }
                
            }];
            _weatherRequestFlag = true;
            
        }
    }
    
    
    else if(_rssi < -FAR_THRESHOLD){
        
        if (_weatherRequestFlag) {
            if (_rainFlag) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                [_blinkTimer invalidate];
                _blinkTimer = nil;
                [Konashi digitalWrite:LED2 value:LOW];
                [Konashi digitalWrite:PIO2 value:LOW];
                
            }
            _weatherRequestFlag = false;
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_findKonashiTimer invalidate];
    _findKonashiTimer = nil;
}


- (IBAction)GetWeatherData :(id)sender {
    
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
    [self blinkTimerCall];

}

- (IBAction)debugButton:(id)sender{
    _rainDebug = !_rainDebug;
    if(_rainDebug)
        self.konashiRSSI.textColor = [UIColor lightGrayColor];
    else
        self.konashiRSSI.textColor = [UIColor whiteColor];

}



- (void)blinkTimerCall{
    _blinkTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f
                                                   target:self
                                                 selector:@selector(blinkTimerLoop:)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)blinkTimerLoop:(NSTimer*)timer {
    
    if(self.rainFlag){
        [Konashi digitalWrite:LED2 value:HIGH];
        [NSThread sleepForTimeInterval:0.1f];
        [Konashi digitalWrite:LED2 value:LOW];
    }

    else {
        [Konashi digitalWrite:PIO2 value:HIGH];
        [NSThread sleepForTimeInterval:0.1f];
        [Konashi digitalWrite:PIO2 value:LOW];
    }
    
    self.blinkCount++;
    
    if (self.blinkCount > NUMBER_OF_BLINK) {
        
        self.blinkCount = 0;
        [_blinkTimer invalidate];
        _blinkTimer = nil;
    }
}

- (void)rssiTimerCall{
    _rssiTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(rssiTimerLoop:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)rssiTimerLoop:(NSTimer*)timer {
    [Konashi signalStrengthReadRequest];
}

- (void)findKonashiTimerCall{
    _findKonashiTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                         target:self
                                                       selector:@selector(findKonashiTimerLoop:)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)findKonashiTimerLoop:(NSTimer*)timer {
    NSLog(@"Find... %@",_myKonashi);
    [Konashi findWithName: _myKonashi];
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

@end
