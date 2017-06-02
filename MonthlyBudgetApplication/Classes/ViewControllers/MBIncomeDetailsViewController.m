//
//  MBIncomeViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBIncomeDetailsViewController.h"
#import "MBDefine.h"

@interface MBIncomeDetailsViewController ()

@end

@implementation MBIncomeDetailsViewController

#pragma mark - Override Parent Class methods
- (NSString *)getNavigationControllerTitle
{
    return NSLocalizedString(@"Your Income",nil);
}

- (NSString *)getTransactionTypeForVC
{
    return kIncomeRecordType;
}

@end
