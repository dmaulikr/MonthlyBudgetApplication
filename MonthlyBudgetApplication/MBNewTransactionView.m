//
//  AddIncomeOrExpenseRecord.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//
#import "MBNewTransactionView.h"
#import "MBTransaction.h"
#import "MBDefine.h"
#import "MBUtility.h"

#define kNewTransactionViewXIBName  @"NewTransactionView"

@implementation MBNewTransactionView
{
    UIViewController*  _onSuperView;
    NSString*          _transactionType;
}

#pragma mark - Initial NIB setup
-(instancetype ) initWithNewTransactionView:(UIViewController* )vc forRecordType:(NSString* )recordType
{
    self = [super init];
    if(self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:kNewTransactionViewXIBName owner:self options:nil]firstObject];
        _onSuperView = vc;
        _transactionType = recordType;

         [self setUpClassElemnets];
        // method sets up frame of view on view controller
        [MBUtility setViewFrameonViewController:self onVieController:vc];
        
        //method invokes animation on view popup
        [MBUtility setUpAnimationOnViewPopUp:self];
    }
    return self;
}

// method setsup class elements
-(void) setUpClassElemnets
{
    [_onSuperView.tabBarController.navigationItem.rightBarButtonItem setEnabled:NO];
    
    [_onSuperView.view addSubview:self];
    
    // changing NIB title
    if([_transactionType isEqualToString:kExpenditureRecordType])
    {
        self.popUpTitleLabel.text = NSLocalizedString(@"ADD NEW EXPENDITURE", nil);
    }
    
    // date text field input view
    MBDatePickerView* datePickerView = [[MBDatePickerView  alloc]initWithDatePicker:self.recordDateTextField];
    self.recordDateTextField.inputView =datePickerView;
}

#pragma mark - Actions on NIB
- (IBAction)saveButtonPressed:(id)sender
{
    [_onSuperView.tabBarController.navigationItem.rightBarButtonItem setEnabled:YES];

    if([self validateTextFields])
    {
        MBTransaction* transaction = [[MBTransaction alloc]init];
        
        // fetching text fields text
        transaction.date = self.recordDateTextField.text;
        transaction.transactionType = _transactionType;
        transaction.amount = self.recordAmountTextField.text.doubleValue;
        transaction.details = self.transactionDetailsTextField.text;
        
         [self removeFromSuperview];
        
        // sending transaction model on main vc
        if(self.onPressingSaveButton)
            self.onPressingSaveButton(transaction);
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [_onSuperView.tabBarController.navigationItem.rightBarButtonItem setEnabled:YES];
    [self removeFromSuperview];
}

// tap gesture associated method
-(IBAction)dismissPopUpView:(id)sender
{
    [self endEditing:YES];
    
}

#pragma mark - TextField Validation Metho
-(BOOL) validateTextFields
{
    if(!self.transactionDetailsTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:NSLocalizedString(@"please enter transaction details",nil) sender:_onSuperView];
        return false;
    }
    if(!self.recordDateTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:NSLocalizedString(@"please enter transaction date",nil) sender:_onSuperView];
        return false;
    }
    if(!self.recordAmountTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:NSLocalizedString(@"please enter transaction amount",nil) sender:_onSuperView];
        return false;
    }
    return true;
}
@end
