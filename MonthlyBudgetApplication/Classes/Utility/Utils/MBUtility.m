//
//  Utility.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBUtility.h"
#import "MBDefine.h"
#import "MBInterval.h"

@implementation MBUtility

// method prompts alert message for user information
+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Monthly Budget", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:ok];
    [sender presentViewController:alert animated:YES completion:nil];
}

// method tells about the current month
+ (NSString *)getCurrentMonthForUserSuggestion
{
    NSArray *_validMonths = kValidMonthArray;

    NSDate *currentDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];

    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    return _validMonths[intMonth - kOneConstant];
}

+ (NSInteger)getCurrentYear
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSInteger intYear = [calender component:NSCalendarUnitYear fromDate:currentDate];
    return intYear;
}

#pragma mark - CustomView Method

// method sets the animation on pop up on view
+ (void)setUpAnimationOnViewPopUp:(UIView *)view
{
    [UIView animateWithDuration:kAnimationDurationConstant animations:
            ^
            {
                view.transform = CGAffineTransformMakeScale(kAnimationTransformationConstant, kAnimationTransformationConstant);
            }
    ];
}

// method sets frame of view on View controller
+ (void)setViewFrameonViewController:(UIView *)view onVieController:(UIViewController *)vc
{
    view.transform = CGAffineTransformMakeScale(kAnimationTransformationConstant, kAnimationTransformationConstant);
    view.center = CGPointMake(vc.view.frame.size.width / kDevideByTwoConstant,
            vc.view.frame.size.height / kDevideByTwoConstant);
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kViewBackgroundAlphaConstant];
}

+ (MBInterval *)getIntervalFromText:(NSString *)text
{
    NSArray<NSString *> *arr = [text componentsSeparatedByString:@" "];
    MBInterval *interval = [[MBInterval alloc] init];
    interval.monthName = arr[0];
    if (arr.count > 1)
        interval.year = arr[1];
    else interval.year = [NSString stringWithFormat:@"%d", (int) [MBUtility getCurrentYear]];
    return interval;

}

+ (NSArray<MBInterval *> *)userSuggestionIntervalWithPrefix:(NSString *)prefix
{
    NSMutableArray<MBInterval *> *array = [[NSMutableArray alloc] init];
    prefix = [prefix componentsSeparatedByString:@" "][0];
    for (NSString *month in kValidMonthArray)
    {
        if ([month hasPrefix:prefix])
        {
            for (int i = (int) [MBUtility getCurrentYear]; i < ([MBUtility getCurrentYear] + kTimeRange); i++)
                [array addObject:[[MBInterval alloc] initWithMonthName:month andYear:[NSString stringWithFormat:@"%d", i]]];
        }
    }

    NSArray <MBInterval *> *sortedArray = [array sortedArrayUsingComparator:^(MBInterval *interval1, MBInterval *interval2)
    {
        return [interval1 compare:interval2];
    }];
    return sortedArray;
}
@end
