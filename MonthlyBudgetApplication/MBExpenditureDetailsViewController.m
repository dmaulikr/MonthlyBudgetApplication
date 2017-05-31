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

@interface MBExpenditureDetailsViewController ()

@end

@implementation MBExpenditureDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialVCSetUp];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    NewTransactionView* recordView = [[NewTransactionView alloc]initWithNewTransactionView:self forRecordType:kExpenditureRecordType];
}

@end
