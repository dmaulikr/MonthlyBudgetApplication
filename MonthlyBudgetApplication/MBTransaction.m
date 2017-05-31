//
//  MBTransaction.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBTransaction.h"
#import "NSDictionary+MonthlyBudget.h"
#import "MBDefine.h"

@implementation MBTransaction

-(MBTransaction *) initWithTransaction:(MBTransaction* )transaction
{
    self = [super init];
    if(self)
    {
        self.monthName = transaction.monthName;
        self.date = transaction.date;
        self.details = transaction.details;
        self.transactionType = transaction.transactionType;
        self.amount = transaction.amount;
    }
    
    return self;
}
@end
