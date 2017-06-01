//
// Created by Mohini on 01/06/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import "TransactionAbstractViewController.h"
#import "MBNewTransactionView.h"
#import "MBCoreDataManager.h"
#import "MBTransactionTableCell.h"

#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"
#define kExpenditureTableViewHieghtConstant 100

@implementation TransactionAbstractViewController
{
//    NSString*                 _transactionType;
    NSArray<MBTransaction * > *_transactions;
}

#pragma mark - View life cycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initialVCSetUp];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // remove popup subview
    [super viewWillDisappear:animated];
    for (UIView *obj in self.view.subviews)
    {
        if (obj.tag == kTransactionViewTag)
            [obj removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSummaryView
{
    self.incomeLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:self.month.totalIncome]];
    self.expenditureLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:self.month.totalExpenditure]];

    //calculate balance
    double balance = self.month.totalIncome - self.month.totalExpenditure;
    if (balance < kConstIntZero)
        self.balanceLabel.textColor = [UIColor redColor];
    else
        self.balanceLabel.textColor = [UIColor blueColor];

    self.balanceLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithDouble:balance]];
}

// method populates data in expenditure table view
- (void)populateData
{
    MBCoreDataManager *coreDataManager = [[MBCoreDataManager alloc] init];

    // fetch list of all expenditure for given month
    _transactions = [coreDataManager fetchTransactionListFromCoreDataForMonth:self.month andType:[self getTransactionTypeForVC]];
    [self updateTransactionData];

    [self setUpSummaryView];
    [self.transactionTableView reloadData];
}

- (void)initialVCSetUp
{
    // UI Elements
    self.tabBarController.navigationItem.title = [self getNavigationControllerTitle];
    self.monthNameLabel.text = [self.month.description uppercaseString];

    [self populateData];

    // adds right bar button to navigation bar
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewTransaction)];

    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)rightBarButtonPressedForAddingNewTransaction
{
    __weak typeof(self) weakSelf = self;

    MBNewTransactionView *newTransactionView = [[MBNewTransactionView alloc] initWithNewTransactionView:self forRecordType:[self getTransactionTypeForVC] forMonthName:self.month.monthName];

    newTransactionView.onPressingSaveButton = ^(MBTransaction *transaction)
    {
        transaction.month_uuid = weakSelf.month.uuid;
        [weakSelf saveNewTransactionRecordToDataBase:transaction];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTransactionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTransactiontableCellIdentifier];

    if (cell == nil)
        cell = [[[NSBundle mainBundle] loadNibNamed:ktransactionTableCellXIBName owner:nil options:nil] firstObject];

    [cell setUpCellAttribiute:_transactions[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExpenditureTableViewHieghtConstant;
}

//#pragma mark - Helper Methods
//// Method calculates total transactions amount
//-(double) calculateTotalTransactionAmount
//{
//    double expenditure = kConstDoubleZero;
//    if(_transactions.count > kConstIntZero)
//    {
//        for(MBTransaction* obj in _transactions)
//        {
//            expenditure = expenditure+ obj.amount;
//        }
//    }
//    return expenditure;
//}

- (NSString *)getTransactionTypeForVC
{
    return nil;
}

- (NSString *)getNavigationControllerTitle
{
    return nil;
}

- (void)updateTransactionData
{
    double sum = kConstDoubleZero;
    if (_transactions.count > kConstIntZero)
    {
        for (MBTransaction *obj in _transactions)
        {
            sum = sum + obj.amount;
        }
    }
    if ([[self getTransactionTypeForVC] isEqualToString:@"Debit"])
    {
        [self.month setTotalExpenditure:sum];
    } else
    {
        [self.month setTotalIncome:sum];
    }
}

// save new expenditure record to database
- (void)saveNewTransactionRecordToDataBase:(MBTransaction *)transaction
{
    MBCoreDataManager *coreDataManager = [[MBCoreDataManager alloc] init];
    [coreDataManager saveTransactionDetailsToCoreData:transaction];

    [self populateData];

    // updated MONTH entity
    [self updateTransactionData];
    [coreDataManager updateMonthRecord:self.month];

    [self setUpSummaryView];
}

//- (NSString *)getTransactionTypeForVC {
//    return nil;
//}
//
//- (NSString *)getNavigationControllerTitle {
//    return nil;
//}


@end
