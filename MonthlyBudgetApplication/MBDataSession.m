//
//  MBDataSession.m
//  MonthlyBudgetApplication
//
//  Created by Mohini on 31/05/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

#import "MBDataSession.h"

@implementation MBDataSession

// method for singalton object
+ (instancetype) sharedObject
{
    static dispatch_once_t once;
    static MBDataSession *sInstance=nil;
    if(sInstance == nil)
    {
        dispatch_once(&once, ^
                      {
                          sInstance = [[MBDataSession alloc] init];
                      });
    }
    return sInstance;
}


@end
