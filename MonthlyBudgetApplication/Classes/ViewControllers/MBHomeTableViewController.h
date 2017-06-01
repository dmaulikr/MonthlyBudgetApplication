//
//  MBHomeTableViewController.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Month+CoreDataClass.h"

@interface MBHomeTableViewController : UITableViewController<UITextFieldDelegate>

@property (strong,nonatomic) Month* month;

@property (strong, nonatomic) IBOutlet UITableView *monthListTableView;
@property (weak, nonatomic) IBOutlet UILabel *noDataAvailableLabel;

@end
