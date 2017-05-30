//
//  Utility.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBUtility.h"

@implementation MBUtility

+ (void)promptMessageOnScreen:(NSString *)message sender:(UIViewController*)sender
{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Monthly Budget" message:message
															preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:ok];
	[sender presentViewController:alert animated:YES completion:nil];
}


@end
