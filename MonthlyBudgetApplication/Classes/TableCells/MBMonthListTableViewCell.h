//
//  MonthListTableViewCell.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMonth.h"

@interface MBMonthListTableViewCell : UITableViewCell

@property (weak,nonatomic)   IBOutlet UILabel* monthNameLabel;
@property (strong,nonatomic) IBOutlet UILabel* totalIncomeLabel;
@property (strong,nonatomic) IBOutlet UILabel* totalExpenditureLabel;

-(void) setUpCellAttributes:(MBMonth* )month;

@end
