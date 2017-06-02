//
//  MBHomeTableViewController.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMonth.h"

@interface MBHomeTableViewController : UITableViewController<UITextFieldDelegate>

@property (strong,nonatomic) MBMonth* month;

@property (strong, nonatomic) IBOutlet UITableView *monthListTableView;

@end
