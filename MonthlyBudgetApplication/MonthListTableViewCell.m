//
//  MonthListTableViewCell.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MonthListTableViewCell.h"

@implementation MonthListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setUpCellAttributes:(MBMonth* )month
{
    self.monthNameLabel.text = month.monthName;
}

@end
