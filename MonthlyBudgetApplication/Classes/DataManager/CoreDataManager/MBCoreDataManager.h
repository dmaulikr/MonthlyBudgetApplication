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
#import "MBTransaction.h"

@interface MBCoreDataManager : NSObject

// MONTH entity methods
- (void)saveMonthToCoreData:(MBMonth* )month;

-(NSArray*)fetchMonthListFromCoreData;

-(void ) updateMonthRecord : (MBMonth * )monthToBeUpdated;

//TRANSACTION Entity methods
-(void) saveTransactionDetailsToCoreData:(MBTransaction* )transaction;

-(NSArray* ) fetchTransactionListFromCoreData:(MBTransaction* )transaction;

@end
