//
//  MBTransactionTableCell.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBTransactionTableCell.h"
#import "MBDefine.h"

@implementation MBTransactionTableCell

#pragma mark - NIB lifecycle methods
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

#pragma mark - Set up cell UI elements
-(void) setUpCellAttribiute:(MBTransaction*) transactionDetails
{
    self.detailsLabel.text = transactionDetails.details;
    self.dateLabel.text = transactionDetails.date;
    self.amountLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Rs. ",nil),[NSNumber numberWithDouble:transactionDetails.amount]];
	
	// set up amount label color for expenditure as red
	if([transactionDetails.transactionType isEqualToString:kExpenditureRecordType])
		self.amountLabel.textColor = [UIColor redColor];
}

@end
