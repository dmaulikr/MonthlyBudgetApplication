//
//  MBTransaction.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction+CoreDataProperties.h"

@interface MBTransaction : NSObject

@property (nonatomic,strong) NSString* date;
@property (nonatomic,strong) NSString* details;
@property (nonatomic,strong) NSString* transactionType;
@property (nonatomic,strong) NSString* monthName;
@property (assign) double amount;

-(MBTransaction *) initWithTransaction:(Transaction* )transaction;

@end
