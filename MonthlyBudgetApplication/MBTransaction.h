//
//  MBTransaction.h
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBTransaction : NSObject

@property (nonatomic,strong) NSString* date;
@property (nonatomic,strong) NSString* details;
@property (nonatomic,strong) NSString* amount;

@end
