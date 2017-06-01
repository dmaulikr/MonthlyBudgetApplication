//
//  Transaction+CoreDataProperties.h
//  MonthlyBudgetApplication
//
//  Created by Anas MD on 6/2/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Transaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

+ (NSFetchRequest<Transaction *> *)fetchRequest;

@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSString *details;
@property (nullable, nonatomic, copy) NSString *transactionType;
@property (nullable, nonatomic, copy) NSString *month_uuid;
@property (nullable, nonatomic, copy) NSString *year;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
