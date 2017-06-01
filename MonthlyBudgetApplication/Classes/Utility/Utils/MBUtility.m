//
//  Utility.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBUtility.h"
#import "MBDefine.h"

@implementation MBUtility

// method prompts alert message for user information
+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController*)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Monthly Budget",nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    [sender presentViewController:alert animated:YES completion:nil];
}

// method tells about the current month
+(NSString* ) getCurrentMonthForUserSuggestion
{
    NSArray* validMonths = kValidMonthArray;
	
    NSDate *currentDate = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    
    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    return  validMonths[intMonth - kOneConstant];
}

+(NSInteger ) getCurrentYear
{
	NSDate *currentDate = [NSDate date];
	NSCalendar* calender = [NSCalendar currentCalendar];
	NSInteger intYear = [calender component:NSCalendarUnitYear fromDate:currentDate];
	return intYear;
}

#pragma mark - CustomView Method
// method sets the animation on pop up on view
+(void) setUpAnimationOnViewPopUp:(UIView* )view
{
    [UIView animateWithDuration:kAnimationDurationConstant animations:
     ^{
         view.transform = CGAffineTransformMakeScale(kAnimationTransformationConstant,kAnimationTransformationConstant);
     }
     ];
}

// method sets frame of view on View controller
+(void) setViewFrameonViewController:(UIView* )view onVieController:(UIViewController* )vc
{
    view.transform = CGAffineTransformMakeScale(kAnimationTransformationConstant,kAnimationTransformationConstant);
    view.center = CGPointMake(vc.view.frame.size.width/kDevideByTwoConstant,
                              vc.view.frame.size.height/kDevideByTwoConstant);
    view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:kViewBackgroundAlphaConstant];
}

+(NSArray <NSString*>*)getMonthsSuggestionFromYear:(NSInteger) yearNum withPrefix:(NSString *)prefix{
    NSArray *monthsArray = kValidMonthArray;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int year = yearNum; year <  (yearNum+3); ++year) {

        for (NSString *str in monthsArray) {
            if ([str hasPrefix:prefix]) {
                NSString *monthName = [NSString stringWithFormat:@"%@ %d", str, year];
                [arr addObject:monthName];
            }
        }
    }

    return arr;


}

+ (NSArray<NSString *> *)splitMonthsAndYear:(NSString *)month {
    return [month componentsSeparatedByString:@" "];
}


@end
