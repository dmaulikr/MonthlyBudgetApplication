//
//  Month.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Month+CoreDataProperties.h"
#import "MBInterval.h"

@interface MBMonth : MBInterval

@property (assign) double totalIncome;
@property (assign) double totalExpenditure;
@property(nonatomic, strong) NSString *uuid;

-(MBMonth *)initWithMonth:(Month* )month;

@end
