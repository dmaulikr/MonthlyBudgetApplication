//
//  MonthListTableViewCell.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBMonthListTableViewCell.h"

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
    self.monthNameLabel.text = month.monthName;
}

@end
