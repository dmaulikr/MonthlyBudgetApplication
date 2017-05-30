//
//  NSDictionary+MonthlyBudget.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "NSDictionary+MonthlyBudget.h"
#import "MBDefine.h"

@implementation NSDictionary (MonthlyBudget)

// method checks if object is of type string or not
-(NSString*)stringForKey:(NSString*)key
{
	NSObject* obj = [self valueForKey:key];
	
	if([obj isKindOfClass:[NSString class]])
	{
		return (NSString*)obj;
	}
	return nil;// returns a default value
	
}

// method checks if object is of type integer or not
-(NSNumber*) numberForKey:(NSString* )key
{
	NSObject* obj = [self valueForKey:key];
	
	if([obj isKindOfClass:[NSNumber class]])
	{
		return (NSNumber*)obj ;
	}
	return kConstIntZero; // returns a default value
}

// method checks if object is of type double or not
-(double) doubleForKey :(NSString*)key
{
	NSObject* obj = [self valueForKey:key];
	if([obj isKindOfClass:[NSNumber class]])
	{
		return [(NSNumber*)obj doubleValue];
	}
	return kConstDoubleZero; // returns a default value
}

//method checks if object is of type array or not
-(NSArray* ) arrayForKey: (NSString* ) Key
{
	NSObject* obj = [self valueForKey:Key];
	
	if([obj isKindOfClass:[NSArray class]])
	{
		return (NSArray* )obj;
	}
	return nil; //returns a default value
}


-(NSDictionary*)dictionaryForKey:(NSString*)key
{
	NSObject* obj = [self valueForKey:key];
	
	if([obj isKindOfClass:[NSDictionary class]])
	{
		return (NSDictionary*)obj;
	}
	return nil;// returns a default value
}

-(BOOL) boolForKey :(NSString* )key
{
	NSObject* obj = [self valueForKey:key];
	
	if([obj isKindOfClass:[NSNumber class]])
	{
		NSNumber* num = (NSNumber*)obj;
		return  [num boolValue];
	}
	else
		return NO;//returns default value
}

@end
