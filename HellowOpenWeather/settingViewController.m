//
//  settingViewController.m
//  tabtest
//
//  Created by Satoshi_Hirazawa on 2014/09/25.
//  Copyright (c) 2014年 Satoshi Hirazawa. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation settingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"bg_settings@2x.png"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    self.settingTable.delegate = self;
    self.settingTable.dataSource = self;
    
    self.settingMenu = @[@"よく行く場所を登録", @"ペアリング"];
    self.settingImageName = @[@"icon_plus.png", @"icon_link.png"];

    UIImage *backgroundImage = [UIImage imageNamed:@"bg_settings.png"];
    self.settingTable.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    
    self.settingTable.tableFooterView = [[UIView alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger dataCount;
    dataCount = self.settingMenu.count;
    
    // テーブルに表示するデータ件数を返す
    return dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.settingMenu[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.settingImageName[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([_settingMenu[indexPath.row]  isEqual: @"よく行く場所を登録"]){
        [self performSegueWithIdentifier:@"RegionalSettingsView" sender:self];
    }
    else if([_settingMenu[indexPath.row]  isEqual: @"ペアリング"]){
        [self performSegueWithIdentifier:@"ParingSettingsView" sender:self];
    }
//    else if([_settingMenu[indexPath.row]  isEqual: @"etc."]){
//        [self performSegueWithIdentifier:@"EtcSettingsView" sender:self];
//    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (IBAction)mainViewReturnActionForSegue:(UIStoryboardSegue *)segue {
    
}


- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}



@end
