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
- (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.persistentContainer viewContext];
    return context;
}

#pragma mark - CRUD Operations on MONTH Entity
// method saves month details to the database
- (void)saveMonthToCoreData:(MBInterval* )interval
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *monthEntityDescription = [NSEntityDescription entityForName:kMonthEntityKey inManagedObjectContext:context];
    NSManagedObject *newMonth = [[NSManagedObject alloc] initWithEntity:monthEntityDescription insertIntoManagedObjectContext:context];

    NSString *uuid = [[NSUUID UUID] UUIDString];
    [newMonth setValue:interval.monthName forKey:kMonthNameKey];
    [newMonth setValue:interval.year forKey:kYearKey];
    [newMonth setValue:uuid forKey:kUUIDKey];
    
    NSError *error = nil;
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
        NSMutableArray <MBMonth *>*arr = [[NSMutableArray alloc]init];
        
        for(MBMonth* obj in array)// iterating over array to get list of all months
        {
            Month* mnth = (Month*)obj;
            MBMonth* monthModel = [[MBMonth alloc]initWithMonth:mnth];
            [arr addObject:monthModel];
        }

        // sort months bases on month + year first
        return [arr sortedArrayUsingComparator:^(MBMonth *m1, MBMonth *m2){
            return [m1 compare:m2];
        }];
    }
    return  nil;
}

// update record of month entity
-(void ) updateMonthRecord : (MBMonth * )monthToBeUpdated
{
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:kMonthEntityKey];
    
    // updating value of the MONTH entity
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"uuid==%@",monthToBeUpdated.uuid];
    fetchRequest.predicate=predicate;
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
    NSString *uuid = [[NSUUID UUID] UUIDString];

    [newTransaction setValue:transaction.date forKey:kTransactionDateKey];
    [newTransaction setValue:transaction.details forKey:kTransactionDetailKey];
    [newTransaction setValue:@(transaction.amount) forKey:kTransactionAmountKey];
    [newTransaction setValue:transaction.transactionType forKey:kTransactionTypeKey];
    [newTransaction setValue:uuid forKey:kUUIDKey];
    [newTransaction setValue:transaction.month_uuid forKey:kMonthUUIDKey];


    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

// fetch list of all transactions from databsae based on transaction type
-(NSArray<MBTransaction*>* ) fetchTransactionListFromCoreDataForMonth:(MBMonth* )month andType:(NSString*) transactionType
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kTransactionEntityKey];
    
    // fetching transation for a particular month depending upon transaction type
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"month_uuid==%@ AND transactionType=%@", month.uuid, transactionType];
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
        // sort transactions by date
        return [arr sortedArrayUsingComparator:^(MBTransaction *t1, MBTransaction *t2){
            return [t1.date compare:t2.date];
        }];
    }

    return  nil;
}

@end
