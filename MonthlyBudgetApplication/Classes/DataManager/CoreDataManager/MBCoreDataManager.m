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

// get NSManaged Context
- (NSManagedObjectContext* )managedObjectContext
{
    AppDelegate * appDelegate = (AppDelegate* )[UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = [appDelegate.persistentContainer viewContext];
    return context;
}

#pragma mark - CRUD Operations on MONTH Entity
// method saves month details to the database
- (void)saveMonthToCoreData:(MBMonth* )monthInputedByUser
{
    NSManagedObjectContext* context = [self managedObjectContext];
    NSEntityDescription *monthEntityDescription = [NSEntityDescription entityForName:kMonthEntityKey inManagedObjectContext:context];
    NSManagedObject* newMonth = [[NSManagedObject alloc] initWithEntity:monthEntityDescription insertIntoManagedObjectContext:context];
    
    [newMonth setValue:monthInputedByUser.monthName forKey:kMonthNameKey];
    
    NSError* error = nil;
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

// method fetches list of all months in database
-(NSArray*) fetchMonthListFromCoreData
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kMonthEntityKey];
    NSArray* array = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if(array.count > kConstIntZero)
    {
        NSMutableArray <MBMonth* >*arr = [[NSMutableArray alloc]init];
        
        for(MBMonth* obj in array)// iterating over array to get list of all months
        {
            Month* mnth = (Month*)obj;
            MBMonth* monthModel = [[MBMonth alloc]initWithMonth:mnth];
            [arr addObject:monthModel];
        }
        return arr;
    }
    return  nil;
}

// update record of month entity
-(void ) updateMonthRecord : (MBMonth * )monthToBeUpdated
{
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:kMonthEntityKey];
    
    // updating value of the MONTH entity
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"monthName==%@",monthToBeUpdated.monthName];     fetchRequest.predicate=predicate;
    MBMonth* newMonthdetails =[[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    
    // setting new values of MONTH entity
    [newMonthdetails setValue: [NSNumber numberWithDouble: monthToBeUpdated.totalIncome] forKey:kIncomeKey];
    [newMonthdetails setValue:[NSNumber numberWithDouble:monthToBeUpdated.totalExpenditure] forKey:kExpenseKey];
    
    [self.managedObjectContext save:nil];
}

#pragma mark - CRUD Operations on TRANSACTION entity
// save new transaction details to database
-(void) saveTransactionDetailsToCoreData:(MBTransaction* )transaction
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *transactionEntityDescription = [NSEntityDescription entityForName:kTransactionEntityKey inManagedObjectContext:context];
    NSManagedObject *newTransaction = [[NSManagedObject alloc] initWithEntity:transactionEntityDescription insertIntoManagedObjectContext:context];
    
    // setting attributes of TRANSATION entity
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

// fetch list of all transactions from databsae based on transaction type
-(NSArray* ) fetchTransactionListFromCoreData:(MBTransaction* )transaction
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kTransactionEntityKey];
    
    // fetching transation for a particular month depending upon transaction type
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"monthName == %@ AND transactionType == %@", transaction.monthName,transaction.transactionType];
    
    NSArray* array = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    if(array.count > kConstIntZero)
    {
        NSMutableArray <MBTransaction *>*arr = [[NSMutableArray alloc]init];
        for(MBTransaction* obj in array)// iterating over array to get list of all transactions
        {
            Transaction* trans = (Transaction*)obj;
            MBTransaction* transModel = [[MBTransaction alloc]initWithTransaction:trans];
            [arr addObject:transModel];
        }
        return arr;
    }
    return  nil;
}

@end
