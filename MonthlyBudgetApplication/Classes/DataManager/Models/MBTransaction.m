//
//  MBTransaction.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBTransaction.h"

@implementation MBTransaction

- (MBTransaction *)initWithTransaction:(Transaction *)transaction
{
    self = [super init];
    if (self)
    {
        self.details = transaction.details;
        self.transactionType = transaction.transactionType;
        self.amount = transaction.amount;
        self.uuid = transaction.uuid;
        self.month_uuid = transaction.month_uuid;
        self.date = transaction.date;
    }
    return self;
}

- (void)setDateFromString:(NSString *)str
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
    self.date = [dateFormat dateFromString:str];
}

- (NSString *)formattedDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    return [dateFormatter stringFromDate:self.date];

}
@end
