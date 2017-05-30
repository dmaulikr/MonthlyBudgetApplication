//
//  NSDictionary+MonthlyBudget.h
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MonthlyBudget)

-(NSString*)stringForKey:(NSString*)key;
-(NSNumber*)numberForKey:(NSString* )key;

-(NSArray* )arrayForKey: (NSString* ) Key;
-(NSDictionary*)dictionaryForKey:(NSString*)key;

-(BOOL) boolForKey :(NSString* )key;
-(double) doubleForKey :(NSString*)key;

@end
