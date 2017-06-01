//
//  MBIncomeViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBIncomeDetailsViewController.h"
#import "MBNewTransactionView.h"
#import "MBDefine.h"
#import "MBTransactionTableCell.h"
#import "MBTransaction.h"
#import "MBCoreDataManager.h"


#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"

#define kIncomeTableViewHieghtConstant 100

@interface MBIncomeDetailsViewController ()

@end

@implementation MBIncomeDetailsViewController
{
    NSArray<MBTransaction* >* _creditDetailsArray;
    NSString*                 _transactionType;
}

- (NSString *)getNavigationControllerTitle {
    return NSLocalizedString(@"Your Income",nil);
}

- (NSString *)getTransactionTypeForVC {
    return @"Credit";
}

@end
