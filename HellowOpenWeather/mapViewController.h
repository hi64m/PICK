    //
//  mapViewController.h
//  PICK
//
//  Created by Satoshi_Hirazawa on 2014/11/14.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface mapViewController : UIViewController
<UIBarPositioningDelegate ,MKAnnotation,CLLocationManagerDelegate>{
    
}
@property (weak, nonatomic) IBOutlet MKMapView *myMap;
@property (weak, nonatomic) IBOutlet UIButton *buttons;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, strong) NSTimer *waitTimer;
@property (nonatomic) CLLocationCoordinate2D umbrellaCoord;

@property BOOL mapFlag;

- (id)initWithCoordinates:(CLLocationCoordinate2D)_coordinate title:(NSString *)_title subtitle:(NSString *)_subtitle;
- (IBAction)test:(id)sender;


@end


