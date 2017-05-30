//
//  MonthListTableViewCell.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBMonth.h"

@interface MonthListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *monthNameLabel;
-(void) setUpCellAttributes:(MBMonth* )month;

@end
