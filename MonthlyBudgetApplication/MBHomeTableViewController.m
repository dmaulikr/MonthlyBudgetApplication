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
#import "MBExpenditureDetailsViewController.h"

#define kMonthListTableViewCellIdentifier @"MonthListTableCell"
#define kSegueHomeToMonthDetailsVC   @"HomeToMonthDetailsVC"

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
	

	UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewMonth)];
	
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    [self populateData];
}

-(void) populateData
{
    MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
    _monthArray = [obj fetchMonthListFromCoreData];
    [self.tableView reloadData];
}

-(void) rightBarButtonPressedForAddingNewMonth
{

    AddNewMonthView* addNewMonthView = [[AddNewMonthView alloc]initWithAddNewMonthView:self];

    addNewMonthView.onPressingSaveButton = ^(NSString* string)
    {
        [self saveMonthToDatabase:string];
    };
   
}

-(void) saveMonthToDatabase:(NSString* )monthInputedByUser
{
    BOOL monthAlreadyPresent = NO;
    for(MBMonth* obj in _monthArray)
    {
        [monthInputedByUser lowercaseString];
        [obj.monthName lowercaseString];
        if([monthInputedByUser isEqualToString:obj.monthName])
        {
            [MBUtility promptMessageOnScreen:@"Month already added by you,try and edit its details" sender:self];
            monthAlreadyPresent = YES;
            break;
        }
    }
    if(!monthAlreadyPresent)
    {
    [self.month setMonthName:monthInputedByUser];
    MBCoreDataManager* obj = [[MBCoreDataManager alloc]init];
    [obj saveMonthToCoreData:self.month];
    }
}



#pragma mark - Table view data source and delegates

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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kSegueHomeToMonthDetailsVC sender:indexPath];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSIndexPath* indexpath = (NSIndexPath* )sender;
////    if([segue.identifier isEqualToString:kSegueHomeToMonthDetailsVC])
////    {
////        MBExpenditureDetailsViewController* destVC = [segue destinationViewController];
////        if(_monthArray[indexpath.row].monthName.length)
////        destVC.monthName = _monthArray[indexpath.row].monthName;
////        
////    }
//}


@end
