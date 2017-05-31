//
//  MBTransactionTableCell.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTransaction.h"


@interface MBTransactionTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

-(void) setUpCellAttribiute:(MBTransaction*) transactionDetails;
@end
