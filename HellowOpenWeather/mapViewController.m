//
//  mapViewController.m
//  PICK
//
//  Created by Satoshi_Hirazawa on 2014/11/14.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "mapViewController.h"
#import "Konashi.h"

@interface mapViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation mapViewController

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

@synthesize locationManager;
@synthesize myMap;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(disconnected) name:KONASHI_EVENT_DISCONNECTED];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) { // iOS8以降
        
    }
    else { // iOS7以前
        // 位置測位スタート
        NSLog(@"ios7");
        [locationManager startUpdatingLocation];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

- (id)initWithCoordinates:(CLLocationCoordinate2D)_coordinate title:(NSString *)_title subtitle:(NSString *)_subtitle
{
    self = [super self];
    if(self != nil){
        coordinate = _coordinate;
        title = _title;
        subtitle = _subtitle;
    }
    return self;
}

- (IBAction)test:(id)sender {
//    [myMap removeAnnotations: myMap.annotations];
//    
//    CLLocationCoordinate2D coordinateYou =  CLLocationCoordinate2DMake(_umbrellaCoord.latitude, _umbrellaCoord.longitude);
//    NSString *titleYou = @"You're here!";
//    NSString *subtitleYou = @"homhom";
//    mapViewController *annotationYou = [[mapViewController alloc] initWithCoordinates:coordinateYou title:titleYou subtitle:subtitleYou];
//    [myMap addAnnotation:annotationYou];
//
    self.mapFlag = !self.mapFlag;
    if(self.mapFlag)
        self.buttons.tintColor = [UIColor lightGrayColor];
    else
        self.buttons.tintColor = [UIColor whiteColor];
    
    NSLog(@"%d", self.mapFlag);

    
}



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) { // iOS8以降
            // 位置情報測位の許可を求めるメッセージを表示する
            NSLog(@"ios8");
            //[locationManager requestAlwaysAuthorization]; // 常に許可
            [self.locationManager requestWhenInUseAuthorization]; // 使用中のみ許可
            
        }
    }
    
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        // 位置測位スタート
        //        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    
    _umbrellaCoord.latitude = newLocation.coordinate.latitude;
    _umbrellaCoord.longitude = newLocation.coordinate.longitude;
    
    NSLog(@"%f %f", _umbrellaCoord.latitude, _umbrellaCoord.longitude);
    
    // 位置測位を終了する
    [locationManager stopUpdatingLocation];
    
}


- (void)disconnected {
    
    
    if(self.mapFlag){
        
        _umbrellaCoord.latitude = 35.700226;
        _umbrellaCoord.longitude = 139.774166;
    }
        
        [locationManager startUpdatingLocation];
    
    
    [self waitTimerCall];
}


- (void)waitTimerCall{
    _waitTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                  target:self
                                                selector:@selector(waitTimerLoop:)
                                                userInfo:nil
                                                 repeats:NO];
}


- (void)waitTimerLoop:(NSTimer*)timer {
    [myMap removeAnnotations: myMap.annotations];
    
    CLLocationCoordinate2D coordinateYou =  CLLocationCoordinate2DMake(_umbrellaCoord.latitude, _umbrellaCoord.longitude);
    NSString *titleYou = @"You're here!";
    NSString *subtitleYou = @"homhom";
    mapViewController *annotationYou = [[mapViewController alloc] initWithCoordinates:coordinateYou title:titleYou subtitle:subtitleYou];
    [myMap addAnnotation:annotationYou];
    
    
    
    [_waitTimer invalidate];
    _waitTimer = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
