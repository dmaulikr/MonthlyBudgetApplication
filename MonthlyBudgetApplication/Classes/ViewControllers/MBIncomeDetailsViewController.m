//
//  MBIncomeViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBIncomeDetailsViewController.h"
#import "MBNewTransactionView.h"


#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"

#define kIncomeTableViewHieghtConstant 100

@interface MBIncomeDetailsViewController ()

@end

@implementation MBIncomeDetailsViewController
{
    NSArray<MBTransaction * > *_transactions;

}

- (NSString *)getNavigationControllerTitle
{
    return NSLocalizedString(@"Your Income", nil);
}

- (NSString *)getTransactionTypeForVC
{
    return @"Credit";
}

@end
