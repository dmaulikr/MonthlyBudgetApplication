//
//  MBExpenditureDetailsViewController.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Month+CoreDataClass.h"

@interface MBExpenditureDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *expenditureListTableView;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenditureLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthNameLabel;

@property (strong,nonatomic) Month* month;

@end
