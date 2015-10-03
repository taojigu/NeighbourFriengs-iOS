//
//  ThirdPartManager.m
//  NeighbourFriends
//
//  Created by gus on 15/10/3.
//  Copyright © 2015年 gujitao. All rights reserved.
//

#import "ThirdPartManager.h"
#import <MAMapKit/MAMapKit.h>

@implementation ThirdPartManager

+(void)load
{
    [MAMapServices sharedServices].apiKey = @"ba96c8608356a7f066ae5f74500c3ad7";
}

@end
