//
//  AddNewMonthView.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewMonthView : UIView
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITableView *monthSuggestionTableView;

@property (strong,nonatomic) void (^onPressingSaveButton)(NSString* text);
@property (strong,nonatomic) void (^onPressingCancelButton)();


- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
-(instancetype) initWithAddNewMonthView:(UIViewController* )vc;

@end
