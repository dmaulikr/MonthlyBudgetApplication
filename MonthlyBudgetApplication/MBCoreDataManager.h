//
//  MBCoreDataManager.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBMonth.h"
#import "AppDelegate.h"

@interface MBCoreDataManager : NSObject

- (void)saveMonthToCoreData:(MBMonth* )month;

-(NSArray*)fetchMonthListFromCoreData;

@end
