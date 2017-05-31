//
//  MBDatePickerView.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MBDefine.h"

@interface MBDatePickerView : UIDatePicker
-(MBDatePickerView*) initWithDatePicker:(UITextField* )textFieldToEdit;

@end
