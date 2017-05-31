//
//  MBIncomeViewController.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBIncomeDetailsViewController.h"
#import "NewTransactionView.h"
#import "MBDefine.h"
#import "MBTransactionTableCell.h"
#import "MBTransaction.h"

#define kTransactionTableCellIdentifierName  @"TransactionCell"
#define kTransactionTableCellXIBName         @"TransactionTableCell"


@interface MBIncomeDetailsViewController ()

@end

@implementation MBIncomeDetailsViewController
{
    NSArray<MBTransaction* >* _creditDetailsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialVCSetUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialVCSetUp
{
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonPressedForAddingNewIncome)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void) rightBarButtonPressedForAddingNewIncome
{
    NewTransactionView* recordView = [[NewTransactionView alloc]initWithNewTransactionView:self forRecordType:kIncomeRecordType];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _creditDetailsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTransactionTableCell* cell = [tableView dequeueReusableCellWithIdentifier:kTransactionTableCellIdentifierName];
    
    if(cell == nil)
        cell = [[[NSBundle mainBundle]loadNibNamed:kTransactionTableCellXIBName owner:nil options:nil] firstObject];
    [cell setUpCellAttribiute:_creditDetailsArray[indexPath.row]];
    return cell;
}

@end
