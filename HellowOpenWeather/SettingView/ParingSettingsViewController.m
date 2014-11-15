//
//  ParingSettingsViewController.m
//  HellowOpenWeather
//
//  Created by Satoshi_Hirazawa on 2014/09/30.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "ParingSettingsViewController.h"
#import "Konashi.h"

#define MY_KONASHI @"No konashi"

@interface ParingSettingsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation ParingSettingsViewController

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


    UIImage *backgroundImage = [UIImage imageNamed:@"bg_settings_long.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(ready) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(connected) name:KONASHI_EVENT_CONNECTED];
    [Konashi addObserver:self selector:@selector(disconnected) name:KONASHI_EVENT_DISCONNECTED];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *outMyKonashiName = [ud objectForKey:@"MY_KONASHI"];
//    NSLog(@" : %@" , outMyKonashiName);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)find:(id)sender {
    [Konashi find];
}


- (void)ready {
    [Konashi pinMode:PIO4 mode:OUTPUT];
    [Konashi digitalWrite:PIO5 value:HIGH];
}


- (void)connected {
    
    NSString *inMyKonashiName = [Konashi peripheralName];
    
    AppDelegate *appDelegate;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    appDelegate.delegateMyKonashiName = inMyKonashiName;
    
    userMyKonashi = [NSUserDefaults standardUserDefaults];
    [userMyKonashi setObject:inMyKonashiName forKey:@"MY_KONASHI"];
    [userMyKonashi synchronize];
    
    NSLog(@"connected : %@" , [Konashi peripheralName]);
    
}

- (void)disconnected {
    NSLog(@"disconnected");

}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
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
