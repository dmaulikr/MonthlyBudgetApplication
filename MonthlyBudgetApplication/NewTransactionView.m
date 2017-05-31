//
//  AddIncomeOrExpenseRecord.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "NewTransactionView.h"
#import "MBDefine.h"

#define kNewTransactionViewXIBName  @"NewTransactionView"

@implementation NewTransactionView
{
    UIViewController*  _onSuperView;
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

@end
