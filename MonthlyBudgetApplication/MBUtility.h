//
//  Utility.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MBUtility : NSObject

+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController*)sender;
+(NSString* ) getCurrentMonthForUserSuggestion;
@end
