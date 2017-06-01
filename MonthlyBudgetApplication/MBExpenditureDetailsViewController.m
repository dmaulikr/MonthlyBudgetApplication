//
//  MBExpenditureDetailsViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBExpenditureDetailsViewController.h"
#import "MBNewTransactionView.h"
#import "MBDefine.h"
#import "MBTransaction.h"
#import "MBCoreDataManager.h"
#import "MBTransactionTableCell.h"

#define kTransactiontableCellIdentifier @"TransactionCell"
#define ktransactionTableCellXIBName    @"TransactionTableCell"

#define kExpenditureTableViewHieghtConstant 100

@interface MBExpenditureDetailsViewController ()

@end

@implementation MBExpenditureDetailsViewController
{
    NSString*                 _transactionType;
    NSArray<MBTransaction* >* _expenditureListArray;
}

#pragma mark - View life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
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
	
	// remove popup subview
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

#pragma mark - Initial vc setups
-(void) setUpSummaryView
{
    self.incomeLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalIncome]];
    self.expenditureLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:self.month.totalExpenditure]];
    
    //calculate balance
    double balance = self.month.totalIncome - self.month.totalExpenditure;
	if(balance < kConstIntZero)
		self.balanceLabel.textColor = [UIColor redColor];
	else
		self.balanceLabel.textColor = [UIColor blueColor];
	
    self.balanceLabel.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:balance]];
}

// method populates data in expenditure table view
-(void) populateData
{
    MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
    
    MBTransaction* transaction = [[MBTransaction alloc]init];
    transaction.monthName = self.month.monthName;
    transaction.transactionType = _transactionType;
    
    // fetch list of all expenditure for given month
    _expenditureListArray = [coreDataManager fetchTransactionListFromCoreData:transaction];
    
    [self.month setTotalExpenditure:[self calculateTotalExpenditure]];
    
    [self setUpSummaryView];
    [self.expenditureListTableView reloadData];
}

-(void) initialVCSetUp
{
    _transactionType = kExpenditureRecordType;
	
	// UI Elements
	self.tabBarController.navigationItem.title = NSLocalizedString(@"Your Expenses",nil);
	self.monthNameLabel.text = self.month.monthName;

    [self populateData];
    
    // adds right bar button to navigation bar
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewIncome)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - Actions on VC
// Action on Navigation right bar button item
-(void) rightBarButtonPressedForAddingNewIncome
{
    __weak typeof(self) weakSelf = self;
    
    MBNewTransactionView* newTransactionView = [[MBNewTransactionView alloc]initWithNewTransactionView:self forRecordType:kExpenditureRecordType forMonthName:self.month.monthName];
    
    newTransactionView.onPressingSaveButton = ^(MBTransaction* transaction)
    {
        transaction.monthName = weakSelf.month.monthName;
        [weakSelf saveNewTransactionRecordToDataBase:transaction];
    };
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
    return kExpenditureTableViewHieghtConstant;
}

#pragma mark - Helper Methods
// Method calculates totalExpenditure
-(double) calculateTotalExpenditure
{
    double expenditure = kConstDoubleZero;
    if(_expenditureListArray.count > kConstIntZero)
    {
        for(MBTransaction* obj in _expenditureListArray)
        {
            expenditure = expenditure+ obj.amount;
        }
    }
    return expenditure;
}

// save new expenditure record to database
-(void) saveNewTransactionRecordToDataBase:(MBTransaction* )transaction
{
    MBCoreDataManager* coreDataManager = [[MBCoreDataManager alloc]init];
    [coreDataManager saveTransactionDetailsToCoreData:transaction];
    
    [self populateData];
    
    // updated MONTH entity
    [self.month setTotalExpenditure:[self calculateTotalExpenditure]];
    [coreDataManager updateMonthRecord:self.month];
    
    [self setUpSummaryView];
}
@end
