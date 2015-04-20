//
//  SearchDvvyUsersViewController.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/19/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "SearchDvvyUsersViewController.h"
#import "SWRevealViewController.h"

@interface SearchDvvyUsersViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

@end


@implementation SearchDvvyUsersViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonItem setTarget: self.revealViewController];
        [self.barButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
    
}

@end
