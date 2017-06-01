//
// Created by Anas MD on 6/2/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBInterval : NSObject
@property (strong,nonatomic) NSString* monthName;
@property (strong, nonatomic) NSString *year;

-(MBInterval *)initWithMonthName:(NSString *)monthName andYear:(NSString *)year;

- (NSComparisonResult)compare:(MBInterval *)obj;
@end