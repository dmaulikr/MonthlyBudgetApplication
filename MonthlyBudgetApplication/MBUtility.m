//
//  Utility.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBUtility.h"

@implementation MBUtility
{
  
}

+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController*)sender
{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Monthly Budget" message:message
															preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:ok];
	[sender presentViewController:alert animated:YES completion:nil];
}

+(NSString* ) getCurrentMonthForUserSuggestion
{
   NSArray*  _validMonths = [[NSArray alloc]initWithObjects:@"january",@"febuary",@"march",@"april",@"may",@"june",@"july",@"august",@"september",@"october",@"november",@"december" ,nil];
    NSDate *currentDate = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    //    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    
    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    NSString* currentMonth = _validMonths[intMonth - 1];
    return currentMonth;
}


@end
