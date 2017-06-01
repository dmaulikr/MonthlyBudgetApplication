//
//  Transaction+CoreDataProperties.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 01/06/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
}

@dynamic amount;
@dynamic date;
@dynamic details;
@dynamic monthName;
@dynamic transactionType;

@end
