//
//  AddIncomeOrExpenseRecord.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDatePickerView.h"
#import "MBTransaction.h"

@interface NewTransactionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *modeOfRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *popUpTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *modeOfRecordTextField;
@property (weak, nonatomic) IBOutlet UITextField *recordDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *recordAmountTextField;

@property (strong,nonatomic) void (^onPressingSaveButton) (MBTransaction* transaction);
- (IBAction)saveButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;
-(instancetype ) initWithNewTransactionView:(UIViewController* )vc forRecordType:(NSString* )recordType;
-(IBAction)dismissPopUpView:(id)sender;


@end
