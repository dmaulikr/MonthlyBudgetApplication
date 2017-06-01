//
// Created by Anas MD on 6/2/17.
// Copyright (c) 2017 Mohini Sindhu . All rights reserved.
//

#import "MBInterval.h"
#import "MBDefine.h"


@implementation MBInterval {

}
- (MBInterval *)initWithMonthName:(NSString *)monthName andYear:(NSString *)year {
    self = [super init];
    if(self)
    {
        self.monthName = monthName;
        self.year = year;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.monthName, self.year];
}

-(NSComparisonResult) compare:(MBInterval *)obj
{
    if([self.year isEqualToString:obj.year])
        return (NSComparisonResult) ([kValidMonthArray indexOfObject:self.monthName] - [kValidMonthArray indexOfObject: obj.monthName]);
    else
        return [self.year compare:obj.year];
}

@end