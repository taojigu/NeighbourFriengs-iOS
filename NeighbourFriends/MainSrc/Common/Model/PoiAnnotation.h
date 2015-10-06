//
//  PoiAnnotation.h
//  NeighbourFriends
//
//  Created by gus on 15/10/5.
//  Copyright © 2015年 gujitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoiAnnotation : NSObject<MAAnnotation>

-(instancetype)initWithPoiDictionary:(NSDictionary*)dict;

/*!
 @brief 标注view中心坐标
 */
@property (nonatomic) CLLocationCoordinate2D coordinate;

/*!
 @brief 获取annotation标题
 @return 返回annotation的标题信息
 */
@property (nonatomic, copy) NSString *title;

/*!
 @brief 获取annotation副标题
 @return 返回annotation的副标题信息
 */
@property (nonatomic, copy) NSString *subtitle;


@end
