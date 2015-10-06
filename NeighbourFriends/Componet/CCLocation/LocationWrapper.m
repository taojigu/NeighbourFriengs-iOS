//
//  LocationWrapper.m
//  NeighbourFriends
//
//  Created by gus on 15/10/6.
//  Copyright © 2015年 gujitao. All rights reserved.
//

#import "LocationWrapper.h"
#import <CoreLocation/CoreLocation.h>


@implementation LocationWrapper


+(LocationWrapper*)sharedWrapper
{
    static dispatch_once_t token;
    static LocationWrapper* wrapper = nil;
    if (nil == wrapper)
    {
        dispatch_once(&token, ^{
            wrapper = [[LocationWrapper alloc]init];
        });
    }
    return wrapper;
}

-(NSString*)distance:(double)srcLatitude srcLongtitude:(double)srcLongtitude destLatitude:(double)destLatitude destLongtitude:(double)destLongtitude
{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(srcLatitude,srcLongtitude));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(destLatitude,destLongtitude));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    
    NSString* dist = [NSString stringWithFormat:@"%g 米",distance];
    return dist;
}
@end
