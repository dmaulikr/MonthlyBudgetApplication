//
//  MBCoreDataManager.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Month+CoreDataClass.h"
#import "AppDelegate.h"
#import "Transaction+CoreDataProperties.h"


@interface MBCoreDataManager : NSObject

// MONTH entity methods
-(NSArray*)fetchMonthListFromCoreData;
- (void)saveMonthToCoreData:(Month* )month;
-(void ) updateMonthRecord : (Month * )monthToBeUpdated;

//TRANSACTION Entity methods
-(void) saveTransactionDetailsToCoreData:(Transaction* )transaction;
-(NSArray* ) fetchTransactionListFromCoreData:(Transaction* )transaction;

@end
