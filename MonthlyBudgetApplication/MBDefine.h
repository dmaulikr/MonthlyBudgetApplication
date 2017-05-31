//
//  Define.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBDefine : NSObject

//UIColors in application
#define kAppMainColor [UIColor colorWithRed:0.871 green:0.345 blue:0.388 alpha:1.0]

//Numeric constants
#define kConstIntZero 0
#define kConstDoubleZero 0.0

//Entity Keys
#define kMonthEntityKey @"Month"

//Application Constants
#define kAppNAmeConstant @"MonthlyBudgetApplication"

//record Type
#define kExpenditureRecordType @"Debit"
#define kIncomeRecordType     @"Credit"

// General
#define kTextColorKey       @"textColor"
@end
