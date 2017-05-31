//
//  MBExpenditureDetailsViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBExpenditureDetailsViewController.h"
#import "NewTransactionView.h"
#import "MBDefine.h"
#import "MBTransaction.h"
#import "MBCoreDataManager.h"
#import "MBTransactionTableCell.h"

#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"
@interface MBExpenditureDetailsViewController ()

@end

@implementation MBExpenditureDetailsViewController
{
    NSString* _transactionType;
    NSArray<MBTransaction* >* _expenditureListArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _transactionType = kExpenditureRecordType;
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
    
    _expenditureListArray = [coreDataManager fetchTransactionListFromCoreData:transaction];
    [self.month setTotalExpenditure:[self calculateTotalExpenditure]];
    [self setUpSummaryView];
    [self.expenditureListTableView reloadData];
}

-(void) initialVCSetUp
{
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewIncome)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void) rightBarButtonPressedForAddingNewIncome
{
    NewTransactionView* newTransactionView = [[NewTransactionView alloc]initWithNewTransactionView:self forRecordType:kExpenditureRecordType];
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
    
    [self.month setTotalExpenditure:[self calculateTotalExpenditure]];
    [coreDataManager updateMonthRecord:self.month];
    [self setUpSummaryView];
}


#pragma mark - TableView Data source and Dalegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _expenditureListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTransactionTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kTransactiontableCellIdentifier];
    if(cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:ktransactionTableCellXIBName owner:nil options:nil]firstObject];
    
    [cell setUpCellAttribiute:_expenditureListArray[indexPath.row]];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


-(double) calculateTotalExpenditure
{
    double expenditure = 0.0;
    if(_expenditureListArray.count > 0)
    {
        for(MBTransaction* obj in _expenditureListArray)
        {
            expenditure = expenditure+ obj.amount;
        }
    }
    return expenditure;
}
@end
