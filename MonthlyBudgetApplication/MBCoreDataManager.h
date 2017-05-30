//
//  MBCoreDataManager.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBMonth.h"

@interface MBCoreDataManager : NSObject

- (void)saveMonthToCoreData:(MBMonth* )month;
-(void) fetchMonthListFromCoreData;

@end
