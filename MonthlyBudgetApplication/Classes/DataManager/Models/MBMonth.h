//
//  Month.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Month+CoreDataProperties.h"

@interface MBMonth : NSObject

@property (strong,nonatomic) NSString* monthName;
@property (assign) double totalIncome;
@property (assign) double totalExpenditure;
@property (strong, nonatomic) NSString* year;

-(MBMonth *) initWithMonth:(Month* )month;

@end
