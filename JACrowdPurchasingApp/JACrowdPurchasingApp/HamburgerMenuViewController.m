//
//  HamburgerMenuViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/19/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "HamburgerMenuViewController.h"
#import "SWRevealViewController.h"

@interface HamburgerMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *userFullName;

@property (weak, nonatomic) IBOutlet UITableView *menuListTableView;

@end


@implementation HamburgerMenuViewController

NSArray *menuItems;


- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.menuListTableView.delegate = self;
    self.menuListTableView.dataSource = self;
    
    menuItems = @[@"home", @"search", @"friends", @"settings", @"logout"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
