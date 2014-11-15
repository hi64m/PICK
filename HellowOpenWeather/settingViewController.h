//
//  settingViewController.h
//  tabtest
//
//  Created by Satoshi_Hirazawa on 2014/09/25.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import <UIKit/UIKit.h>

NSArray *itemList;
@interface settingViewController : UIViewController
<UIBarPositioningDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *settingMenu;
@property (nonatomic, strong) NSArray *settingImageName;


@property (weak, nonatomic) IBOutlet UIImage *plusIcon;
@property (weak, nonatomic) IBOutlet UIImage *linkIcon;

@property (weak, nonatomic) IBOutlet UITextField *getCityName;
@property (weak, nonatomic) IBOutlet UITableView *settingTable;

@end
