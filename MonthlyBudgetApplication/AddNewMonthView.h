//
//  AddNewMonthView.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewMonthView : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITableView *monthSuggestionTableView;

@property (strong,nonatomic) void (^onPressingSaveButton)(NSString* text);

- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
-(instancetype) initWithAddNewMonthView:(UIViewController* )vc;

@end
