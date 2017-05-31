//
//  MBDataSession.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBDataSession : NSObject

@property (strong,nonatomic) NSString* currentMonth;
+ (instancetype) sharedObject;

@end
