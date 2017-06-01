//
//  MBDatePickerView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBDatePickerView.h"

#define kDateFormat         @"dd MMMM yyyy"
#define kCurrentYear        @"2017"
#define kFirstDateOfMonth   @"1"
#define k31LastDateConstant @"31"
#define k30LastDateConstant @"30"
#define k28LastDateConstant @"28"

@implementation MBDatePickerView
{
    UITextField *_textField;
}

#pragma mark - Initial Date picker Setup

// method gets instance of Date picker
- (MBDatePickerView *)initWithDatePicker:(UITextField *)textFieldToEdit forMonthName:(NSString *)monthName
{
    self = [super init];
    if (self)
    {
        _textField = textFieldToEdit;
        [self setInitialSetUps];
        [self setRangeForPickerView:monthName];
        [self addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

// method does initial set up of UIDatePicker view
- (void)setInitialSetUps
{
    [self setDate:[NSDate date]]; //this returns today's date
    self.datePickerMode = UIDatePickerModeDate; // this lets picker view show only dates
}

// method sets Range of picker view for which date needs to be displayed
- (void)setRangeForPickerView:(NSString *)monthName
{
    //set maximum and minimum dates of the date pickerview
    NSString *maxDateString = [NSString stringWithFormat:@"%@ %@ %@", [self maximumDateForMonth:monthName], monthName, kCurrentYear];

    NSString *minDateString = [NSString stringWithFormat:@"%@ %@ %@", kFirstDateOfMonth, monthName, kCurrentYear];

    // the date formatter used to convert string to date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // the specific format to use
    dateFormatter.dateFormat = kDateFormat;

    // converting string to date
    NSDate *theMaximumDate = [dateFormatter dateFromString:maxDateString];
    NSDate *theMinimumDate = [dateFormatter dateFromString:minDateString];

    [self setMaximumDate:theMaximumDate];
    [self setMinimumDate:theMinimumDate];
}

#pragma mark - Actions on UIDatePicker

- (void)datePickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:kDateFormat]; // format in which we want time to be dispalyed
    _textField.text = [outputFormatter stringFromDate:self.date];
}

#pragma mark - Method to retrieve dates for a month

// method gets the maximum date of a given month
- (NSString *)maximumDateForMonth:(NSString *)currentMonth
{
    [currentMonth lowercaseString];

    // case : month have last date 31
    if ([currentMonth isEqualToString:kMonthJanuary] || [currentMonth isEqualToString:kMonthMarch] || [currentMonth isEqualToString:kMonthMay] || [currentMonth isEqualToString:kMonthJuly] || [currentMonth isEqualToString:kMonthAugust] || [currentMonth isEqualToString:kMonthOctober] || [currentMonth isEqualToString:kMonthDecember])
        return k31LastDateConstant;

    //case : exceptional case feb
    if ([currentMonth isEqualToString:kMonthFebuary])
        return k28LastDateConstant;

    //case : month have last date 30
    return k30LastDateConstant;
}

@end
