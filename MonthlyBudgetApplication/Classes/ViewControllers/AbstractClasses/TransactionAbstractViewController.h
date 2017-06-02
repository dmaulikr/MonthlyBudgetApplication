//
// Created by Mohini on 01/06/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMonth.h"

/* Class is the base class for EXPENTITURE VC and INCOME VC .They both will override it*/

@interface TransactionAbstractViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *transactionTableView;

@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenditureLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthNameLabel;

@property (strong,nonatomic) MBMonth* month;

// methods to be overriden by child class
-(NSString *) getTransactionTypeForVC;
-(NSString *) getNavigationControllerTitle;

@end
