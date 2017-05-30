//
//  Month+CoreDataProperties.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Month+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Month (CoreDataProperties)

+ (NSFetchRequest<Month *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *monthName;

@end

NS_ASSUME_NONNULL_END
