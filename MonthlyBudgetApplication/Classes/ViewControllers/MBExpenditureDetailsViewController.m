//
//  MBExpenditureDetailsViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBExpenditureDetailsViewController.h"
#import "MBNewTransactionView.h"
#import "MBDefine.h"
#import "MBTransaction.h"
#import "MBCoreDataManager.h"
#import "MBTransactionTableCell.h"

#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"

#define kExpenditureTableViewHieghtConstant 100

@interface MBExpenditureDetailsViewController ()

@end

@implementation MBExpenditureDetailsViewController


- (NSString *)getNavigationControllerTitle {
    return NSLocalizedString(@"Your Expenses",nil);
}

- (NSString *)getTransactionTypeForVC {
    return @"Debit";
}


@end
