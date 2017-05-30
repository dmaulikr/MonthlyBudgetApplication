//
//  AddNewMonthView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "AddNewMonthView.h"
#define kAddNewMonthViewXIBName @"AddNewMonthView"

@implementation AddNewMonthView

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
        [vc setUserActivity:nil];
        [UIView animateWithDuration:0.5
                         animations:
         ^{
             self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
             [vc.view setUserInteractionEnabled:NO];
         }
         ];
    }
    return self;
}

- (IBAction)saveButtonPressed:(id)sender
{
    if(self.onPressingSaveButton)
        self.onPressingSaveButton(self.monthTextField.text);
}

- (IBAction)cancelButtonPressed:(id)sender
{
    if(self.onPressingCancelButton)
        self.onPressingCancelButton();
}
@end
