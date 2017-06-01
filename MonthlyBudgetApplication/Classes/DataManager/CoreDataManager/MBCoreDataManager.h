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
-(NSArray*)fetchMonthListFromCoreData;
- (void)saveMonthToCoreData:(MBMonth* )month;
-(void ) updateMonthRecord : (MBMonth * )monthToBeUpdated;

//TRANSACTION Entity methods
-(void) saveTransactionDetailsToCoreData:(MBTransaction* )transaction;

- (NSArray<MBTransaction *> *)fetchTransactionListFromCoreDataForMonth:(MBMonth *)month andType:(NSString *)transactionType;

@end
