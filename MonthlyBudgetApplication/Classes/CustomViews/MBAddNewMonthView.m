//
//  AddNewMonthView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBAddNewMonthView.h"
#import "MBMonthListTableViewCell.h"
#import "MBUtility.h"
#import "MBDefine.h"

#define kAddNewMonthViewXIBName      @"AddNewMonthView"
#define kMonthTableCellXIBIdentifier @"MonthTableCell"
#define kMonthTableCellXIBName       @"MonthTableCell"

@implementation MBAddNewMonthView
{
    NSArray <NSString *> *_validMonths;
    UIViewController *_ownSuperView;
    NSArray<MBInterval *> *_monthSuggestionArray;
}

#pragma mark - Initial NIB setUps

//method add View NIB on view controller's view where ever it is called
- (instancetype)initWithAddNewMonthView:(UIViewController *)vc
{
    self = [super init];
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:kAddNewMonthViewXIBName owner:self options:nil] firstObject];
        _ownSuperView = vc;

        [MBUtility setViewFrameonViewController:self onVieController:vc];
        [self setUpClassElements];
        [MBUtility setUpAnimationOnViewPopUp:self];
    }
    return self;
}

// method initialises initial settings of class elements
- (void)setUpClassElements
{
    _validMonths = kValidMonthArray;

    [_ownSuperView.navigationItem.rightBarButtonItem setEnabled:NO];

    [self.monthSuggestionTableView setHidden:YES];
    [self manageTapGestureOnView];

    [self.monthTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [_ownSuperView.view addSubview:self];

    self.monthTextField.delegate = self;
    self.monthSuggestionTableView.delegate = self;
    self.monthSuggestionTableView.dataSource = self;
}

// method to add tap gesture on view
- (void)manageTapGestureOnView
{
    self.tapGestureOnView = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(dismissPopUpView:)];
    self.tapGestureOnView.cancelsTouchesInView = NO;
    [self addGestureRecognizer:self.tapGestureOnView];
}

#pragma mark - Actions on NIB

- (IBAction)saveButtonPressed:(id)sender
{
    [_ownSuperView.navigationItem.rightBarButtonItem setEnabled:YES];
    [self removeFromSuperview];

    if ([self checkForValidMonthEntered:self.monthTextField.text])
    {
        // sending textfield text on main screen
        if (self.onPressingSaveButton)
            self.onPressingSaveButton([MBUtility getIntervalFromText:self.monthTextField.text]);
    } else
    {
        [MBUtility promptMessageOnScreen:NSLocalizedString(@"Please enter a valid month", nil) sender:_ownSuperView];
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [_ownSuperView.navigationItem.rightBarButtonItem setEnabled:YES];
    [self removeFromSuperview];
}

// tap gesture associated method
- (IBAction)dismissPopUpView:(id)sender
{
    [self endEditing:YES];
}

#pragma mark - User Entry Validation

// method checks whether month input by user is valid or not
- (BOOL)checkForValidMonthEntered:(NSString *)month
{
    // checking for validity of user month input
    MBInterval *interval = [MBUtility getIntervalFromText:month];
    int currentYear = (int) [MBUtility getCurrentYear];

    if ([_validMonths containsObject:interval.monthName] && interval.year.integerValue >= currentYear && interval.year.integerValue < currentYear + kTimeRange)
        return true;
    else
        return false;


}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // for giving first suggestion of current month when user taps on the textfield
    [self.monthSuggestionTableView setHidden:NO];
    NSString *currentMonth = [MBUtility getCurrentMonthForUserSuggestion];
    MBInterval *interval = [MBUtility getIntervalFromText:currentMonth];
    _monthSuggestionArray = @[interval];
    [self.monthSuggestionTableView reloadData];
}

- (void)textFieldDidChange:(id)textFieldDidChange
{
    // to give suggestion while user types in the text field
    NSString *prefix = [self.monthTextField.text lowercaseString];
    if (prefix.length > kConstIntZero)
    {
        _monthSuggestionArray = [MBUtility userSuggestionIntervalWithPrefix:prefix];
        if (_monthSuggestionArray.count == kConstIntZero)
            [self.monthSuggestionTableView setHidden:YES];
        else
        {
            [self.monthSuggestionTableView setHidden:NO];
            [self.monthSuggestionTableView reloadData];
        }
    }
}

#pragma  mark - Table view Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _monthSuggestionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBMonthListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMonthTableCellXIBIdentifier];
    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:kMonthTableCellXIBName owner:nil options:nil] firstObject];


    MBInterval *interval = _monthSuggestionArray[indexPath.row];
    [cell setUpCellAttributesWithInterval:interval];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.monthTextField.text = _monthSuggestionArray[indexPath.row].description;
}

@end
