//
//  Transaction+CoreDataProperties.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 01/06/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Transaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest;

@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *details;
@property (nullable, nonatomic, copy) NSString *monthName;
@property (nullable, nonatomic, copy) NSString *transactionType;

@end

NS_ASSUME_NONNULL_END
