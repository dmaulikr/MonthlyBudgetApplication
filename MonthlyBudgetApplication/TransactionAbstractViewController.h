//
// Created by Mohini on 01/06/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import "MBMonth.h"
#import <UIKit/UIKit.h>


@interface TransactionAbstractViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *transactionTableView;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expenditureLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthNameLabel;

-(NSString *) getTransactionTypeForVC;
-(NSString *) getNavigationControllerTitle;
-(void) updateTransactionData;
@property (strong,nonatomic) MBMonth* month;
@end