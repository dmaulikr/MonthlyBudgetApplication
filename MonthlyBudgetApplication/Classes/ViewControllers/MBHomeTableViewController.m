//
//  MBHomeTableViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini Sindhu  on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBHomeTableViewController.h"
#import "MBUtility.h"
#import "MBCoreDataManager.h"
#import "MBMonthListTableViewCell.h"
#import "MBAddNewMonthView.h"
#import "MBExpenditureDetailsViewController.h"
#import "MBIncomeDetailsViewController.h"
#import "MBDefine.h"

#define kMonthListTableViewCellIdentifier	@"MonthTableCell"
#define kMonthListTableXIBName				@"MonthTableCell"
#define kSegueHomeToMonthDetailsVC			@"HomeToMonthDetailsVC"

@interface MBHomeTableViewController ()

@end

@implementation MBHomeTableViewController
{
	NSArray<MBMonth* >* _monthArray;
}

#pragma mark - View life cycle methods
- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self initialTableVcSetup];
}

#pragma mark - InitialViewControllerSetup
-(void) initialTableVcSetup
{
	self.month = [[MBMonth alloc]init];
	
	// add right button at Navigation Bar
	UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewMonth)];
	
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;
	
	[self populateData];
}

// method populates data in the tableview
-(void) populateData
{
	// fetch list of month from Database
	MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
	_monthArray = [obj fetchMonthListFromCoreData];
	
	[self.tableView reloadData];
}

// Navigation right bar button Action
-(void) rightBarButtonPressedForAddingNewMonth
{
	__weak typeof(self) weakSelf = self;
	
	MBAddNewMonthView* addNewMonthView = [[MBAddNewMonthView alloc]initWithAddNewMonthView:self];
	
	addNewMonthView.onPressingSaveButton = ^(NSString* string)
	{
		[weakSelf saveMonthToDatabase:string];
	};
}

// method saves new month to database
-(void) saveMonthToDatabase:(NSString* )monthInputedByUser
{
	if([self validateMonthInputedByUser:monthInputedByUser])
	{
		[self.month setMonthName:monthInputedByUser];
		
		// save valid month to data base
		MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
		[obj saveMonthToCoreData:self.month];
		
		[self populateData];
	}
}

#pragma mark - Validation Method
// method validates month Inputed by user
-(BOOL) validateMonthInputedByUser:(NSString* )monthInputedByUser
{
	for(MBMonth* obj in _monthArray)
	{
		[monthInputedByUser lowercaseString];
		[obj.monthName lowercaseString];
		
		if([monthInputedByUser isEqualToString:obj.monthName])
		{
			[MBUtility promptMessageOnScreen:NSLocalizedString(@"Month already added by you,try and edit its details",nil) sender:self];
			return false;
		}
	}
	return true;
}

#pragma mark - Table view data source and delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _monthArray.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MBMonthListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMonthListTableViewCellIdentifier];
	
	if(cell == nil)
		cell = [[[NSBundle mainBundle]loadNibNamed:kMonthListTableXIBName owner:nil options:nil] firstObject];
	
	[cell setUpCellAttributes:_monthArray[indexPath.row]];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:kSegueHomeToMonthDetailsVC sender:indexPath];
}

#pragma mark - Navigation methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSIndexPath* indexpath = (NSIndexPath* )sender;
	
	if([segue.identifier isEqualToString:kSegueHomeToMonthDetailsVC])
	{
		MBExpenditureDetailsViewController* expenditureVc = ((UITabBarController*)segue.destinationViewController).viewControllers[kConstIntZero];
		
		MBIncomeDetailsViewController* incomeVC = ((UITabBarController*)segue.destinationViewController).viewControllers[kOneConstant];
		
		if(_monthArray.count> kConstIntZero && _monthArray[indexpath.row])
		{
			MBMonth *month = _monthArray[indexpath.row];
			expenditureVc.month = month;
			incomeVC.month = month;
		}
	}
}

@end
