//
//  DVYHomePageViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVYCampaignDetailView.h"

@interface DVYHomePageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic)  UITableView *selfTableView;

@property (nonatomic)  UITableView *othersTableView;

@property (nonatomic)  UITableView *invitationTableView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

- (void)refresh;

@end
