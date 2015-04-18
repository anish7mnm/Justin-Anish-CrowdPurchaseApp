//
//  DVYHomePageViewController.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 3/20/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVYHomePageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic)  UITableView *selfTableView;
@property (nonatomic)  UITableView *othersTableView;
@property (nonatomic)  UITableView *invitationTableView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

- (void)refresh;

@end
