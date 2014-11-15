//
//  mapViewController.m
//  PICK
//
//  Created by Satoshi_Hirazawa on 2014/11/14.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
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
