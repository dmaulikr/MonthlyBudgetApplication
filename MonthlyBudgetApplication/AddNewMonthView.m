//
//  AddNewMonthView.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 30/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "AddNewMonthView.h"
#import "MBUtility.h"
#import "MonthListTableViewCell.h"
#import "MBMonth.h"

#define kAddNewMonthViewXIBName @"AddNewMonthView"
#define kMonthTableCellXIBIdentifier @"MonthTableCell"
#define kMonthTableCellXIBName     @"MonthTableCell"

@implementation AddNewMonthView
{
    NSArray* _validMonths;
    UIViewController* _ownSuperView;
    NSMutableArray<NSString*>* _monthSuggestionArray;
}

-(instancetype) initWithAddNewMonthView:(UIViewController* )vc
{
    self = [super init];
    if(self)
    {
        
        self = [[[NSBundle mainBundle] loadNibNamed:kAddNewMonthViewXIBName owner:self options:nil]firstObject];
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
        self.center = CGPointMake(vc.view.frame.size.width  / 2,
                                         vc.view.frame.size.height / 2);
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        [vc.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.monthSuggestionTableView setHidden:YES];
        [self.monthTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        // make screen unresponsive
      
        [vc.view addSubview:self];
        _ownSuperView = vc;
       
        [self setUserInteractionEnabled:YES];


        self.monthTextField.delegate  = self;
        self.monthSuggestionTableView.delegate = self;
        self.monthSuggestionTableView.dataSource = self;

        // to add ANIMATION
        [UIView animateWithDuration:0.5
                         animations:
         ^{
             self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
         }
         ];
        _validMonths = [[NSArray alloc]initWithObjects:@"january",@"febuary",@"march",@"april",@"may",@"june",@"july",@"august",@"september",@"october",@"november",@"december" ,nil];
    }
    return self;
}

- (IBAction)saveButtonPressed:(id)sender
{
     [_ownSuperView.navigationItem.rightBarButtonItem setEnabled:YES];
    if([self checkForValidMonthEntry:self.monthTextField.text])
    {
        if(self.onPressingSaveButton)
            self.onPressingSaveButton(self.monthTextField.text);
        [self removeFromSuperview];

    }
    else
    {
        [self removeFromSuperview];
        [MBUtility promptMessageOnScreen:@"Enter a valid Month" sender:_ownSuperView];
    }
    
}

- (IBAction)cancelButtonPressed:(id)sender
{
     [_ownSuperView.navigationItem.rightBarButtonItem setEnabled:YES];
    [self removeFromSuperview];
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


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _monthSuggestionArray = [[NSMutableArray alloc]init];
    [self.monthSuggestionTableView setHidden:NO];
    NSArray* array = [[NSArray alloc]initWithObjects:[MBUtility getCurrentMonthForUserSuggestion], nil];

    for(NSString* obj in array)
    {
        MBMonth* month = [[MBMonth alloc]init];
        [month setMonthName:obj];
        [_monthSuggestionArray addObject:month.monthName];
    }
    [self.monthSuggestionTableView reloadData];

}

-(void)textFieldDidChange:(id)textFieldDidChange
{
    NSLog(@"%@", self.monthTextField.text);
    NSString *prefix = [self.monthTextField.text lowercaseString];
    if (prefix.length>0) {
        
        [_monthSuggestionArray removeAllObjects];
        for (int i = 0; i < _validMonths.count ; ++i) {
            if ([_validMonths[i] hasPrefix:prefix])
                [_monthSuggestionArray addObject:_validMonths[i]];
        }
        if (_monthSuggestionArray.count == 0){
            [self.monthSuggestionTableView setHidden:YES];
        } else{
            [self.monthSuggestionTableView setHidden:NO];
            [self.monthSuggestionTableView reloadData];
        }
    }
    
}

#pragma  mark - Table view Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _monthSuggestionArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MonthListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMonthTableCellXIBIdentifier];
    if(cell == nil)
        cell = [[[NSBundle mainBundle]loadNibNamed:kMonthTableCellXIBName owner:nil options:nil]firstObject];
    MBMonth* month = [[MBMonth alloc]init];
    month.monthName = _monthSuggestionArray[indexPath.row];
    [cell setUpCellAttributes:month];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.monthTextField.text = _monthSuggestionArray[indexPath.row];
}

@end
