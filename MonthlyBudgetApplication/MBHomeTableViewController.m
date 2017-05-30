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
#import "MonthListTableViewCell.h"
#import "AddNewMonthView.h"

#define kMonthListTableViewCellIdentifier @"MonthListTableCell"

@interface MBHomeTableViewController ()

@end

@implementation MBHomeTableViewController
{
	NSArray* _searchSuggestionArray;
	NSArray* _validMonths;
	NSString* _monthInputedByUser;
    NSArray* _monthArray;
    NSArray* _monthSuggestionArray;
    UITableView* _autoCompleteTableView;
}

#pragma mark - View life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initialTableVcSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - InitialViewControllerSetup
-(void) initialTableVcSetup
{
    self.month = [[MBMonth alloc]init];
	_validMonths = [[NSArray alloc]initWithObjects:@"january",@"febuary",@"march",@"april",@"may",@"june",@"july",@"august",@"september",@"october",@"november",@"december" ,nil];

	UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewMonth)];
	
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;
   NSString* currentMonth =  [self getCurrentMonthForUserSuggestion];
    _monthSuggestionArray = [[NSArray alloc]initWithObjects:currentMonth, nil];
    [self populateData];
}
-(void) setUpAutoCompleteTableView
{
    _autoCompleteTableView.delegate = self;
    _autoCompleteTableView.dataSource = self;
    _autoCompleteTableView.frame = CGRectMake(0, 0, 30, 50);
    
}
-(void) populateData
{
    _monthArray = [[NSArray alloc]init];
    MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
    _monthArray = [obj fetchMonthListFromCoreData];
    [self.tableView reloadData];
}

-(void) rightBarButtonPressedForAddingNewMonth
{
//	__weak typeof(self) weakSelf = self;
//
//	[self showPopUpWithTextField:@"Add Month" forView:self withBlock:^(NSString* month)
//	{
//		if([weakSelf checkForValidMonthEntry:month])
//		{
//			_monthInputedByUser = month;
//			[weakSelf saveMonthToDatabase];
//			
//		}
//		else
//			[MBUtility promptMessageOnScreen:@"Please enter valid month" sender:weakSelf];
//		
//	}];
    
    AddNewMonthView* addNewMonthView = [[AddNewMonthView alloc]initWithAddNewMonthView:self];
   
}

-(void) saveMonthToDatabase
{
	[self.month setMonthName:_monthInputedByUser];
	MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
	[obj saveMonthToCoreData:self.month];
}

-(BOOL) checkForValidMonthEntry:(NSString* )month
{
	// checking for validity of user month input
	if(month.length)
	{
		month =  [month lowercaseString];
		for(NSString* obj in _validMonths)
		{
			if([obj isEqualToString:month])
			return true;
		}
	}
	return false;
}
- (void) showPopUpWithTextField:(NSString *)title forView:(UIViewController *)viewController withBlock:(void (^)(NSString *))callBack
{
	__block UITextField* txtFld;
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
	
	// Save action
	[alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Save",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
					  {
						  if(txtFld.text.length)
						  {
							  callBack(txtFld.text);
						  }
						  
					  }]];
	//cancel action
	[alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
					  {
						  [alert removeFromParentViewController];
						  
					  }]];
	// adding text filed to the alert Controller
	[alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
	 {
		 textField.placeholder = NSLocalizedString(@"Enter text:",nil);
		 txtFld = textField;
	 }];
	
	[viewController presentViewController:alert animated:YES completion:nil];
}

-(NSString* ) getCurrentMonthForUserSuggestion
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calender = [NSCalendar currentCalendar];
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    
    NSInteger intMonth = [calender component:NSCalendarUnitMonth fromDate:currentDate];
    NSString* currentMonth = _validMonths[intMonth - 1];
    return currentMonth;
}
#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _monthArray.count;
 
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            MonthListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMonthListTableViewCellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[[NSBundle mainBundle]loadNibNamed:kWishListtabelCellXibName owner:nil options:nil] firstObject];
//    }
        [cell setUpCellAttributes:_monthArray[indexPath.row]];
        return cell;

    
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSArray* autoCompleteFilterArray;
    NSLog(@"Range:%@",NSStringFromRange(range));
    NSLog(@"%@",textField.text);
    
    NSString *passcode = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSLog(@"%@",passcode);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"SELF CONTAINS %@",passcode];
    autoCompleteFilterArray = [_monthSuggestionArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@", autoCompleteFilterArray);
    
    if ([autoCompleteFilterArray count]==0)
    {
        _autoCompleteTableView.hidden = TRUE;
    }else
    {
        _autoCompleteTableView.hidden = FALSE;
    }
    
    [_autoCompleteTableView reloadData];
    
    
    return TRUE;
    
}


@end
