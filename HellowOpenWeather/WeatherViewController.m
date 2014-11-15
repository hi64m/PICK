//
//  WeatherViewController.m
//  HellowWorld
//
//  Created by Satoshi_Hirazawa on 2014/09/13.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "WeatherViewController.h"



@interface WeatherViewController ()

@end

@implementation WeatherViewController

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
    OWMWeatherAPI *weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"66296073b9af3a7f3b24f5db03117c85"];
    [weatherAPI setTemperatureFormat:kOWMTempCelcius];
    
//    [weatherAPI currentWeatherByCityName:@"Tokyo" withCallback:^(NSError *error, NSDictionary *result) {
//        if (error) {
//            // handle the error
//            NSLog(@"API Request Error");
//            return;
//        }
//        
//        // The data is ready
//        
//        NSString *cityName = result[@"name"];
//        NSNumber *currentTemp = result[@"main"][@"temp"];
//        NSNumber *currentHumidity = result[@"main"][@"humidity"];
//        NSLog(@"cityName %@",cityName);
//        NSLog(@"currentTemp %@",currentTemp);
//        NSLog(@"currentHumidity %@",currentHumidity);
//        
//    }];
    
    
    [weatherAPI forecastWeatherByCityName:@"Tokyo" withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            // handle the error
            NSLog(@"API Request Error");
            return;
        }

        // The data is ready

        NSString *cityName = result[@"city"][@"name"];
        NSString *cityId = result[@"city"][@"id"];
//        NSNumber *currentTemp = result[@"list"];
        NSLog(@"cityName %@",cityName);
        NSLog(@"cityId %@",cityId);
//        NSLog(@"currentTemp %@",currentTemp);

    }];
    
    
//    [weatherAPI dailyForecastWeatherByCityName:@"Tokyo" withCount:10 andCallback:^(NSError *error, NSDictionary *result) {
//        if (error) {
//            // handle the error
//            NSLog(@"API Request Error");
//            return;
//        }
//        
//        // The data is ready
//        
//        NSString *cityName = result[@"city"][@"name"];
//        NSString *cityId = result[@"city"][@"id"];
//
//        NSNumber *count = result[@"cnt"];
//        NSNumber *currentTemp = result[@"list"];
//        NSLog(@"cityName %@",cityName);
//        NSLog(@"cityId %@",cityId);
//
//        NSLog(@"cnt %@",count);
//        NSLog(@"currentTemp %@",currentTemp);
//        
//    }];
   
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
