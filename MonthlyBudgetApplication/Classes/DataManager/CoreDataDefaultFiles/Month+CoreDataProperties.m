//
//  Month+CoreDataProperties.m
//  MonthlyBudgetApplication
//
//  Created by Anas MD on 6/2/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Month+CoreDataProperties.h"

@implementation Month (CoreDataProperties)

+ (NSFetchRequest<Month *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Month"];
}

@dynamic expense;
@dynamic income;
@dynamic monthName;
@dynamic uuid;
@dynamic year;

@end
