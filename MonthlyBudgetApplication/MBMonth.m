//
//  Month.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBMonth.h"
#import "NSDictionary+MonthlyBudget.h"
#import "MBDefine.h"

@implementation MBMonth

-(instancetype) initWithMonthDictionary:(NSDictionary* )monthDict
{
	self = [super init];
	if(self)
	{
		self.monthName = [monthDict stringForKey:kMonthNameKey];
	}
	
	return self;
}
@end
