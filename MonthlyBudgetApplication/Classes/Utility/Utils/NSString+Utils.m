//
//  NSString+Utils.m
//  MonthlyBudgetApplication
//
//  Created by Anas MD on 6/2/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

-(NSString *) add:(NSObject *)str
{
    return [NSString stringWithFormat:@"%@%@", self, str];
}


@end
