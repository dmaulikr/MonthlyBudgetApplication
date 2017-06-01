//
//  Month.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBMonth.h"
#import "MBDefine.h"

@implementation MBMonth

-(MBMonth *) initWithMonth:(Month* )month
{
	self = [super init];
	if(self)
	{
		self.monthName = month.monthName;
        self.totalExpenditure = month.expense;
        self.totalIncome = month.income;
	}
	return self;
}
@end
