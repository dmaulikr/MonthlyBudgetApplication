//
//  AddIncomeOrExpenseRecord.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "NewTransactionView.h"
#import "MBDefine.h"
#import "MBUtility.h"
#import "MBTransaction.h"

#define kNewTransactionViewXIBName  @"NewTransactionView"

@implementation NewTransactionView
{
    UIViewController*  _onSuperView;
    NSString* _transactionType;
}

-(instancetype ) initWithNewTransactionView:(UIViewController* )vc forRecordType:(NSString* )recordType
{
    self = [super init];
    if(self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:kNewTransactionViewXIBName owner:self options:nil]firstObject];
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        self.center = CGPointMake(vc.view.frame.size.width  / 2,
                                  vc.view.frame.size.height / 2);
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        [vc.tabBarController.navigationItem.rightBarButtonItem setEnabled:NO];
        _transactionType = recordType;
        [vc.view addSubview:self];
        _onSuperView = vc;
        // to add ANIMATION
        [UIView animateWithDuration:0.5
                         animations:
         ^{
             self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
         }
         ];
        if([recordType isEqualToString:kExpenditureRecordType])
        {
            self.popUpTitleLabel.text = @"ADD NEW EXPENDITURE";
            self.modeOfRecordLabel.text = @"purpose";
        }
        
        MBDatePickerView* datePickerView = [[MBDatePickerView  alloc]initWithDatePicker:self.recordDateTextField];
        self.recordDateTextField.inputView =datePickerView;
    }
    
    return self;
}
- (IBAction)saveButtonPressed:(id)sender
{
    [_onSuperView.tabBarController.navigationItem.rightBarButtonItem setEnabled:YES];

    if([self validateTextFields])
    {

        MBTransaction* transaction = [[MBTransaction alloc]init];
        transaction.date = self.recordDateTextField.text;
        transaction.transactionType = _transactionType;
        transaction.amount = self.recordAmountTextField.text.doubleValue;
        transaction.details = self.modeOfRecordTextField.text;
         [self removeFromSuperview];
        if(self.onPressingSaveButton)
            self.onPressingSaveButton(transaction);
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [_onSuperView.tabBarController.navigationItem.rightBarButtonItem setEnabled:YES];
    [self removeFromSuperview];
}

-(IBAction)dismissPopUpView:(id)sender
{
    [self endEditing:YES];
    
}

-(BOOL) validateTextFields
{
    if(!self.modeOfRecordTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:@"please enter transaction details" sender:_onSuperView];
        return false;
    }
    if(!self.recordDateTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:@"please enter transaction date" sender:_onSuperView];
        return false;
    }
    if(!self.recordAmountTextField.text.length)
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:@"please enter transaction amount" sender:_onSuperView];
        return false;
    }
    return true;
}
@end
