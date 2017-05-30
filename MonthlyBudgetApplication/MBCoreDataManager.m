//
//  MBCoreDataManager.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBCoreDataManager.h"
#import "AppDelegate.h"
#import "MBDefine.h"
#import "MBMonth.h"

@implementation MBCoreDataManager

- (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    
    
//        NSManagedObjectContext *context = nil;
//        id delegate = [[UIApplication sharedApplication] delegate];
//       NSManagedObjectContext *context = [delegate.persistentContainer viewContext];
////
////        if ([delegate performSelector:@selector(managedObjectContext)])
////        
////            context = [delegate managedObjectContext];
//    
//    
	return context;
}

- (void)saveMonthToCoreData:(MBMonth* )monthInputedByUser
{
	NSManagedObjectContext *context = [self managedObjectContext];
	
	// Create a new managed object
    NSManagedObject* newMonth = [NSEntityDescription insertNewObjectForEntityForName:kMonthEntityKey inManagedObjectContext:context];

    [newMonth setValue:monthInputedByUser.monthName forKey:kMonthNameKey];
	
	NSError *error = nil;
	// Save the object to persistent store
	if (![context save:&error])
	{
		NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
	}
}

-(NSArray*) fetchMonthListFromCoreData
{

	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kMonthEntityKey];
	NSArray* array = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
	NSLog(@"%@",array[kConstIntZero]);
    return  array;
}

@end
