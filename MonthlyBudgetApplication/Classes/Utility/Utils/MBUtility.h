//
//  Utility.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBInterval;

@interface MBUtility : NSObject

+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController *)sender;

+ (NSInteger)getCurrentYear;

+ (NSString *)getCurrentMonthForUserSuggestion;

+ (void)setUpAnimationOnViewPopUp:(UIView *)view;

+ (void)setViewFrameonViewController:(UIView *)view onVieController:(UIViewController *)vc;

+ (MBInterval *)getIntervalFromText:(NSString *)text;

+ (NSArray<MBInterval *> *)userSuggestionIntervalWithPrefix:(NSString *)prefix;
@end
