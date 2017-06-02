//
//  MonthListTableViewCell.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBMonthListTableViewCell.h"
#import "MBUtility.h"

@implementation MBMonthListTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setup cell UI elements
-(void) setUpCellAttributes:(MBMonth* )month
{
    self.monthNameLabel.text = 	[NSString stringWithFormat:@"%@ %@",month.monthName,[NSNumber numberWithInteger:[MBUtility getCurrentYear]]];
	
    self.totalIncomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total Income : %.02lf",nil), month.totalIncome ];
	
    self.totalExpenditureLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total Expenditure : %.02lf",nil), month.totalExpenditure ];
}

@end
