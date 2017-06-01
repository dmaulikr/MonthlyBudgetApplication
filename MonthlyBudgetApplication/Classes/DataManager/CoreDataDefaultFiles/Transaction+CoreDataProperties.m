//
//  Transaction+CoreDataProperties.m
//  MonthlyBudgetApplication
//
//  Created by Anas MD on 6/2/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest
{
    return [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
}

@dynamic amount;
@dynamic details;
@dynamic transactionType;
@dynamic month_uuid;
@dynamic year;
@dynamic date;
@dynamic uuid;

@end
