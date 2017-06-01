//
//  AddNewMonthView.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBInterval.h"

@interface MBAddNewMonthView : UIView <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITextField *monthTextField;
@property(weak, nonatomic) IBOutlet UITableView *monthSuggestionTableView;
@property(strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureOnView;

@property(strong, nonatomic) void (^onPressingSaveButton)(MBInterval *text);

- (IBAction)saveButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(id)sender;

- (instancetype)initWithAddNewMonthView:(UIViewController *)vc;

@end
