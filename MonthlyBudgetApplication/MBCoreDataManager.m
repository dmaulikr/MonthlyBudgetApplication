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
#import "Month+CoreDataProperties.h"
#import "MBTransaction.h"
#import "Transaction+CoreDataProperties.h"

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
    NSEntityDescription *monthEntityDescription = [NSEntityDescription entityForName:kMonthEntityKey inManagedObjectContext:context];
    NSManagedObject *newMonth = [[NSManagedObject alloc] initWithEntity:monthEntityDescription insertIntoManagedObjectContext:context];


    [newMonth setValue:monthInputedByUser.monthName forKey:kMonthNameKey];
    NSPersistentContainer* container = [[NSPersistentContainer alloc]initWithName:kAppNAmeConstant];
    NSLog(@"***********************************************************");
    NSLog(@"%@",[container.persistentStoreDescriptions firstObject].URL);

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
    if(array.count > 0)
    {
        NSMutableArray <MBMonth *>*arr = [[NSMutableArray alloc]init];
        
        for(int i = 0 ; i < array.count ; i++){
            Month *m = (Month *)array[i];
            NSLog(@"Current month is %@",m.monthName);
            MBMonth *mnt = [[MBMonth alloc]initWithMonth:m.monthName];
            [arr addObject:mnt];
        }
        return arr;
        
    }
    return  nil;
}

-(void) saveTransactionDetailsToCoreData:(MBTransaction* )transaction
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *transactionEntityDescription = [NSEntityDescription entityForName:kTransactionEntityKey inManagedObjectContext:context];
    NSManagedObject *newTransaction = [[NSManagedObject alloc] initWithEntity:transactionEntityDescription insertIntoManagedObjectContext:context];
    [newTransaction setValue:transaction.date forKey:kTransactionDateKey];
    [newTransaction setValue:transaction.details forKey:kTransactionDetailKey];
    [newTransaction setValue:[NSNumber numberWithDouble:transaction.amount] forKey:kTransactionAmountKey];
    [newTransaction setValue:transaction.transactionType forKey:kTransactionTypeKey];
    [newTransaction setValue:transaction.monthName forKey:kMonthNameKey];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    
}

-(NSArray* ) fetchTransactionListFromCoreData:(MBTransaction* )transaction
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kTransactionEntityKey];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"monthName == %@ AND transactionType == %@", transaction.monthName,transaction.transactionType];

    NSArray* array = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    
    if(array.count > 0)
    {
        NSMutableArray <MBTransaction *>*arr = [[NSMutableArray alloc]init];
        
        
        for(int i = 0 ; i < array.count ; i++){
            Transaction *record = (Transaction *)array[i];
            MBTransaction *trans = (MBTransaction* )[[MBTransaction alloc]initWithTransaction:record];
            [arr addObject:trans];
        }
        return arr;
        
    }
    return  nil;

}

-(void ) updateMonthRecord : (MBMonth * )monthToBeUpdated
{
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:kMonthEntityKey];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"monthName==%@",monthToBeUpdated.monthName]; // If required to fetch specific vehicle
    fetchRequest.predicate=predicate;
    MBMonth* newMonthdetails =[[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    
    [newMonthdetails setValue: [NSNumber numberWithDouble: monthToBeUpdated.totalIncome] forKey:kIncomeKey];
    [newMonthdetails setValue:[NSNumber numberWithDouble:monthToBeUpdated.totalExpenditure] forKey:kExpenseKey];
    
    [self.managedObjectContext save:nil];
}

@end
