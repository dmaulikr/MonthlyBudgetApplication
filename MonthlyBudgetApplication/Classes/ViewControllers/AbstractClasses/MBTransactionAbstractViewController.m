//
// Created by Mohini on 01/06/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import "MBTransactionAbstractViewController.h"
#import "MBNewTransactionView.h"
#import "MBCoreDataManager.h"
#import "MBTransactionTableCell.h"

#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"
#define kExpenditureTableViewHieghtConstant 100

@implementation MBTransactionAbstractViewController
{
	NSArray<MBTransaction* >* _transactionList;
}

#pragma mark - View life cycle methods
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.navigationController.navigationBar.topItem.title = kEmptyStringConstant;
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self initialVCSetUp];
}

-(void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	// remove popup subview (subview to add new transaction record)
	[super viewWillDisappear:animated];
	for (UIView* obj in self.view.subviews)
	{
		if(obj.tag == kTransactionViewTag)
			[obj removeFromSuperview];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - initial VC setup
-(void) setUpTransactionSummaryView
{
	self.incomeLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalIncome]];
	
	self.expenditureLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalExpenditure]];
	
	self.balanceLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:[self calculateBalance]]];
}

// method populates data in expenditure table view
-(void) populateDataInTableView
{
	MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
	
	// set up Transaction entity
	MBTransaction* transaction = [[MBTransaction alloc]init];
	transaction.monthName = self.month.monthName;
	transaction.transactionType = [self getTransactionTypeForVC];
	
	// fetch list of all expenditure for given month
	_transactionList = [coreDataManager fetchTransactionListFromCoreData:transaction];
	
	// methods will update transaction data on VC after fetching transaction list
	[self updateTransactionData];
	[self setUpTransactionSummaryView];
	[self.transactionTableView reloadData];
}

-(void) initialVCSetUp
{
	// UI Elements
	self.tabBarController.navigationItem.title = [self getNavigationControllerTitle];
	self.monthNameLabel.text = [self.month.monthName uppercaseString];
	
	[self populateDataInTableView];
	
	// adds right bar button to navigation bar
	UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewTransaction)];
	
	self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - Actions on VC
// Action :  right bar button on navigation bar
-(void) rightBarButtonPressedForAddingNewTransaction
{
	__weak typeof(self) weakSelf = self;
	
	MBNewTransactionView* newTransactionView = [[MBNewTransactionView alloc]initWithNewTransactionView:self forRecordType:[self getTransactionTypeForVC] forMonthName:self.month.monthName];
	
	newTransactionView.onPressingSaveButton = ^(MBTransaction* transaction)
	{
		transaction.monthName = weakSelf.month.monthName;
		[weakSelf saveNewTransactionRecordToDataBase:transaction];
	};
}

#pragma mark - Table View Delegates and Datasources
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _transactionList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MBTransactionTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kTransactiontableCellIdentifier];
	
	if(cell == nil)
		cell = [[[NSBundle mainBundle] loadNibNamed:ktransactionTableCellXIBName owner:nil options:nil]firstObject];
	
	[cell setUpCellAttribiute:_transactionList[indexPath.row]];
	
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kExpenditureTableViewHieghtConstant;
}

#pragma mark - Methods to be overriden by Child class
- (NSString *)getTransactionTypeForVC
{
	return nil;
}

- (NSString *)getNavigationControllerTitle
{
	return nil;
}

#pragma mark - Helper Methods
- (void)updateTransactionData
{
	double sum = kConstDoubleZero;
	if(_transactionList.count > kConstIntZero)
	{
		for(MBTransaction* obj in _transactionList)
			sum = sum + obj.amount;
	}
	
	// update self.month
	if ([[self getTransactionTypeForVC] isEqualToString:kExpenditureRecordType])
		[self.month setTotalExpenditure:sum];
	else
		[self.month setTotalIncome:sum];
}

// save new expenditure record to database
-(void) saveNewTransactionRecordToDataBase:(MBTransaction* )transaction
{
	MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
	[coreDataManager saveTransactionDetailsToCoreData:transaction];
	
	[self populateDataInTableView];
	
	// updated MONTH entity
	[self updateTransactionData];
	[coreDataManager updateMonthRecord:self.month];
	
	[self setUpTransactionSummaryView];
}

// calculates total balance
-(double) calculateBalance
{
	//calculate balance
	double balance = self.month.totalIncome - self.month.totalExpenditure;
	if(balance < kConstIntZero)
		self.balanceLabel.textColor = [UIColor redColor];
	else
		self.balanceLabel.textColor = [UIColor blueColor];
	return  balance;
}

@end
