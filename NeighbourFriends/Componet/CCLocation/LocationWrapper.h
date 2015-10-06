//
//  LocationWrapper.h
//  NeighbourFriends
//
//  Created by gus on 15/10/6.
//  Copyright © 2015年 gujitao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocationWrapper : NSObject


+(LocationWrapper*)sharedWrapper;


-(NSString*)distance:(double)srcLatitude srcLongtitude:(double)srcLongtitude destLatitude:(double)destLatitude destLongtitude:(double)destLongtitude;

@end
