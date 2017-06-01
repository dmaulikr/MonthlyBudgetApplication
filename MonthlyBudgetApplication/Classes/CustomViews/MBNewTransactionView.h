//
//  AddIncomeOrExpenseRecord.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDatePickerView.h"
#import "Transaction+CoreDataProperties.h"

@interface MBNewTransactionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *popUpTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *transactionDetailsTextField;
@property (weak, nonatomic) IBOutlet UITextField *recordDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *recordAmountTextField;

@property (strong,nonatomic) void (^onPressingSaveButton) (Transaction* transaction);

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
-(IBAction)dismissPopUpView:(id)sender;

-(instancetype ) initWithNewTransactionView:(UIViewController* )vc forRecordType:(NSString* )recordType forMonthName:(NSString* )monthName;

@end
