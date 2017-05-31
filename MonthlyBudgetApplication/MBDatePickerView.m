//
//  MBDatePickerView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBDatePickerView.h"
#import "MBUtility.h"
#define kDateFormat @"dd"

@implementation MBDatePickerView
{
    UITextField* _textField;
}

// method gets instance of Date picker
-(MBDatePickerView*) initWithDatePicker:(UITextField* )textFieldToEdit
{
    self = [super init];
    if(self)
    {
        
        
        
        _textField = textFieldToEdit;
//        self = [[MBDatePickerView alloc]init];
        [self setDate:[NSDate date]]; //this returns today's date
        
        // theMinimumDate (which signifies the oldest a person can be) and theMaximumDate (defines the youngest a person can be) are the dates you need to define according to your requirements, declare them:
        
        // the date string for the minimum age required (change according to your needs)
        NSString *maxDateString = [NSString stringWithFormat:@"%@,%@,%@",[self maximumDateForMonth],[MBUtility getCurrentMonthForUserSuggestion],@"2017"];
        NSString* minDateString = [NSString stringWithFormat:@"%@,%@,%@",@"1",[MBUtility getCurrentMonthForUserSuggestion],@"2017"];
        // the date formatter used to convert string to date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // the specific format to use
        dateFormatter.dateFormat = kDateFormat;
        // converting string to date
        NSDate *theMaximumDate = [dateFormatter dateFromString: maxDateString];
        NSDate* theMinimumDate = [dateFormatter dateFromString:minDateString];
        
        // repeat the same logic for theMinimumDate if needed
        
        // here you can assign the max and min dates to your datePicker
        [self setMaximumDate:theMaximumDate]; //the min age restriction
        [self setMinimumDate:theMinimumDate]; //the max age restriction (if needed, or else dont use this line)
        
        // set the mode
//        [self setDatePickerMode:UIDatePickerModeDate];

//        [self setLocale:[NSLocale systemLocale]]; // for 24 hour format
        
        [self addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void) datePickerValueChanged:(UIDatePicker*) sender
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:kDateFormat]; // format in which we want time to be dispalyed
    NSString* date = [outputFormatter stringFromDate:self.date];
    _textField.text = date;
    
    // update the textfield with the date everytime it changes with selector defined below
//    [self addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // and finally set the datePicker as the input mode of your textfield

}

-(NSString* ) maximumDateForMonth
{
    NSString* currentMonth = [MBUtility getCurrentMonthForUserSuggestion];
    if([currentMonth isEqualToString:@"january"] || [currentMonth isEqualToString:@"march"] || [currentMonth isEqualToString:@"may"] || [currentMonth isEqualToString:@"july"] || [currentMonth isEqualToString:@"august"] || [currentMonth isEqualToString:@"october"] || [currentMonth isEqualToString:@"december"] )
    {
        return @"31";
    }
    
    else if ([currentMonth isEqualToString:@"febuary"])
    {
        return @"28";
    }
    return @"30";
}

@end
