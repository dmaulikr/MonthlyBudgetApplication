//
//  MBExpenditureDetailsViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBExpenditureDetailsViewController.h"
#import "MBDefine.h"

@interface MBExpenditureDetailsViewController ()

@end

@implementation MBExpenditureDetailsViewController

#pragma mark - Override Parent Class methods
- (NSString *)getNavigationControllerTitle
{
    return NSLocalizedString(@"Your Expenses",nil);
}

- (NSString *)getTransactionTypeForVC
{
    return kExpenditureRecordType;
}

@end
