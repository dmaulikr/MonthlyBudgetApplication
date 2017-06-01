//
//  MBIncomeViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBIncomeDetailsViewController.h"
#import "MBNewTransactionView.h"
#import "MBDefine.h"
#import "MBTransactionTableCell.h"
#import "MBTransaction.h"
#import "MBCoreDataManager.h"


#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"


@interface MBIncomeDetailsViewController ()

@end

@implementation MBIncomeDetailsViewController
{
    NSArray<MBTransaction* >* _creditDetailsArray;
    NSString* _transactionType;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _transactionType = kIncomeRecordType;
    [self setUpSummaryView];
    
    [self populateData];
    [self initialVCSetUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setUpSummaryView
{
    self.incomeLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalIncome]];
    self.expenditureLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalExpenditure]];
    double balance = self.month.totalIncome - self.month.totalExpenditure;
    if(balance < 0)
        self.balanceLabel.textColor = [UIColor redColor];
   
    self.balanceLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:balance]];
}
-(void) populateData
{
    MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
    MBTransaction* transaction = [[MBTransaction alloc]init];
    transaction.monthName = self.month.monthName;
    transaction.transactionType = _transactionType;
    
    _creditDetailsArray = [coreDataManager fetchTransactionListFromCoreData:transaction];
    [self.month setTotalIncome:[self calculateTotalIncome]];
    [self setUpSummaryView];
    [self.incomeTableView reloadData];
}

-(void) initialVCSetUp
{
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewIncome)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void) rightBarButtonPressedForAddingNewIncome
{
    MBNewTransactionView* newTransactionView = [[MBNewTransactionView alloc]initWithNewTransactionView:self forRecordType:_transactionType];
    newTransactionView.onPressingSaveButton = ^(MBTransaction* transaction)
    {
        transaction.monthName = self.month.monthName;
        [self saveNewTransactionRecordToDataBase:transaction];
    };
}

-(void) saveNewTransactionRecordToDataBase:(MBTransaction* )transaction
{
    MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
    [coreDataManager saveTransactionDetailsToCoreData:transaction];
    [self populateData];
    
    [self.month setTotalIncome:[self calculateTotalIncome]];
    [coreDataManager updateMonthRecord:self.month];
    [self setUpSummaryView];
}


#pragma mark - TableView Data source and Dalegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _creditDetailsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTransactionTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kTransactiontableCellIdentifier];
    if(cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:ktransactionTableCellXIBName owner:nil options:nil]firstObject];
    
    [cell setUpCellAttribiute:_creditDetailsArray[indexPath.row]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


-(double) calculateTotalIncome
{
    double income = 0.0;
    if(_creditDetailsArray.count > 0)
    {
        for(MBTransaction* obj in _creditDetailsArray)
        {
            income = income + obj.amount;
        }
    }
    return income;
}

@end
