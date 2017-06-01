//
//  MBTransaction.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBTransaction.h"
#import "MBDefine.h"

@implementation MBTransaction

-(MBTransaction *) initWithTransaction:(Transaction* )transaction
{
    self = [super init];
    if(self)
    {
        self.monthName = transaction.monthName;
        self.date = transaction.date;
        self.details = transaction.details;
        self.transactionType = transaction.transactionType;
        self.amount = transaction.amount;
        self.year = transaction.year;
    }
    return self;
}
@end
