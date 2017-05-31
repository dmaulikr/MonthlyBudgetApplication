//
//  AddNewMonthView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "AddNewMonthView.h"
#import "MBUtility.h"
#import "MonthListTableViewCell.h"
#import "MBMonth.h"

#define kAddNewMonthViewXIBName @"AddNewMonthView"
#define kMonthTableCellXIBIdentifier @"MonthTableCell"
#define kMonthTableCellXIBName     @"MonthTableCell"

@implementation AddNewMonthView
{
    NSArray* _validMonths;
    UIViewController* _ownSuperView;
    NSMutableArray<MBMonth*>* _monthSuggestionArray;
}

-(instancetype) initWithAddNewMonthView:(UIViewController* )vc
{
    self = [super init];
    if(self)
    {
        
        self = [[[NSBundle mainBundle] loadNibNamed:kAddNewMonthViewXIBName owner:self options:nil]firstObject];
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        self.center = vc.view.center;
        // Add to the view hierarchy
        [self.monthSuggestionTableView setHidden:YES];
        [vc.view addSubview:self];
        _ownSuperView = vc;

        self.monthTextField.delegate  = self;
        self.monthSuggestionTableView.delegate = self;
        self.monthSuggestionTableView.dataSource = self;

        // to add ANIMATION
        [UIView animateWithDuration:0.5
                         animations:
         ^{
             self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
         }
         ];
        _validMonths = [[NSArray alloc]initWithObjects:@"january",@"febuary",@"march",@"april",@"may",@"june",@"july",@"august",@"september",@"october",@"november",@"december" ,nil];
    }
    return self;
}

- (IBAction)saveButtonPressed:(id)sender
{
    if([self checkForValidMonthEntry:self.monthTextField.text])
    {
        if(self.onPressingSaveButton)
            self.onPressingSaveButton(self.monthTextField.text);

    }
    else
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:@"Enter a valid Month" sender:_ownSuperView];
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender
{
    
    [self removeFromSuperview];
}


-(BOOL) checkForValidMonthEntry:(NSString* )month
{
    // checking for validity of user month input
    if(month.length)
    {
        month =  [month lowercaseString];
        for(NSString* obj in _validMonths)
        {
            if([obj isEqualToString:month])
                return true;
        }
    }
    return false;
}

-(NSString* ) getCurrentMonthForUserSuggestion
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
    //    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    
    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    NSString* currentMonth = _validMonths[intMonth - 1];
    return currentMonth;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _monthSuggestionArray = [[NSMutableArray alloc]init];
    [self.monthSuggestionTableView setHidden:NO];
    NSArray* array = [[NSArray alloc]initWithObjects:[self getCurrentMonthForUserSuggestion], nil];

    for(NSString* obj in array)
    {
        MBMonth* month = [[MBMonth alloc]init];
        [month setMonthName:obj];
        [_monthSuggestionArray addObject:month];
    }
    [self.monthSuggestionTableView reloadData];
    
}


#pragma  mark - Table view Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _monthSuggestionArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMonthTableCellXIBIdentifier];
    if(cell == nil)
        cell = [[[NSBundle mainBundle]loadNibNamed:kMonthTableCellXIBName owner:nil options:nil]firstObject];
    [cell setUpCellAttributes:_monthSuggestionArray[indexPath.row]];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.monthTextField.text = _monthSuggestionArray[indexPath.row].monthName;
}

@end
