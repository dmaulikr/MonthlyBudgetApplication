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
#define kDevideByTwoConstant 2
#define kOneConstant        1

//Entity Keys
#define kMonthEntityKey         @"Month"
#define kTransactionEntityKey   @"Transaction"

// Attribute Keys
#define kTransactionDateKey   @"date"
#define kTransactionDetailKey @"details"
#define kTransactionTypeKey   @"transactionType"
#define kTransactionAmountKey @"amount"
#define kMonthNameKey         @"monthName"
#define kExpenseKey           @"expense"
#define kIncomeKey            @"income"

//Application Constants
#define kAppNAmeConstant       @"MonthlyBudgetApplication"

//record Type
#define kExpenditureRecordType @"Debit"
#define kIncomeRecordType      @"Credit"

// General
#define kTextColorKey       @"textColor"

//month Name
#define kMonthJanuary   @"january"
#define kMonthFebuary   @"february"
#define kMonthMarch     @"march"
#define kMonthApril     @"april"
#define kMonthMay       @"may"
#define kMonthJune      @"june"
#define kMonthJuly      @"july"
#define kMonthAugust    @"august"
#define kMonthSepetmber @"september"
#define kMonthOctober   @"october"
#define kMonthNovember  @"november"
#define kMonthDecember  @"december"

//custom view constants
#define  kAnimationTransformationConstant 1.0f
#define kAnimationDurationConstant        0.5
#define kViewBackgroundAlphaConstant      0.3

// valid months arrray
#define kValidMonthArray  @[kMonthJanuary,kMonthFebuary,kMonthMarch,kMonthApril,kMonthMay,kMonthJune,kMonthJuly,kMonthAugust,kMonthSepetmber,kMonthOctober,kMonthNovember,kMonthDecember];

@end
