//
//  Month+CoreDataProperties.h
//  MonthlyBudgetApplication
//
//  Created by Anas MD on 6/2/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Month+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Month (CoreDataProperties)

+ (NSFetchRequest<Month *> *)fetchRequest;

@property (nonatomic) double expense;
@property (nonatomic) double income;
@property (nullable, nonatomic, copy) NSString *monthName;
@property (nullable, nonatomic, copy) NSString *uuid;
@property (nullable, nonatomic, copy) NSString *year;

@end

NS_ASSUME_NONNULL_END
