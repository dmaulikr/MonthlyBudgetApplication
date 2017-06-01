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
    NSArray* _validMonths = kValidMonthArray;
	
    NSDate *currentDate = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    
    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    return  _validMonths[intMonth - kOneConstant];
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

@end
