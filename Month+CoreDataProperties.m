//
//  Month+CoreDataProperties.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Month+CoreDataProperties.h"

@implementation Month (CoreDataProperties)

+ (NSFetchRequest<Month *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Month"];
}

@dynamic monthName;

@end
