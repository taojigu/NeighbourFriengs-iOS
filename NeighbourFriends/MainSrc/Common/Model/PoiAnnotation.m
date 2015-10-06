//
//  PoiAnnotation.m
//  NeighbourFriends
//
//  Created by gus on 15/10/5.
//  Copyright © 2015年 gujitao. All rights reserved.
//

#import "PoiAnnotation.h"

@interface PoiAnnotation ()
{
    
}

@property(nonatomic,strong)NSDictionary* dictionary;

@end

@implementation PoiAnnotation


-(instancetype)initWithPoiDictionary:(NSDictionary*)dict
{
    self = [super init];
    self.dictionary = dict;
    return self;
}


-(NSString*)title
{
    return self.dictionary[KeyPoiName];
}

-(NSString*)subtitle
{
    return self.dictionary[KeyPoiDistance];
}

-(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D cdnt;
    NSNumber* latNumber=[self.dictionary valueForKey:KeyPoiLatitude];
    NSNumber* longNumber = [self.dictionary valueForKey:KeyPoiLongtitude];
    cdnt.latitude = [latNumber doubleValue];
    cdnt.longitude = [longNumber doubleValue];
    return cdnt;
}
@end
