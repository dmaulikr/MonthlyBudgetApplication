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
-(void)setUpCellAttributesWithMonth:(MBMonth* )month
{
    self.monthNameLabel.text = 	month.description;
	
    self.totalIncomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total Income : %.02lf",nil), month.totalIncome ];
    self.totalExpenditureLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Total Expenditure : %.02lf",nil), month.totalExpenditure ];
}

-(void) setUpCellAttributesWithInterval:(MBInterval* )interval
{
    self.monthNameLabel.text = 	interval.description;
}

@end
