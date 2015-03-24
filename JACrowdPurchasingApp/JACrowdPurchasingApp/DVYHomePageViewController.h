//
//  DVYHomePageViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVYHomePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UITableView *selfTableView;
@property (weak, nonatomic) IBOutlet UITableView *othersTableView;
@property (weak, nonatomic) IBOutlet UITableView *invitationTableView;
@property (weak, nonatomic) IBOutlet UIView *buttonView;


@end
