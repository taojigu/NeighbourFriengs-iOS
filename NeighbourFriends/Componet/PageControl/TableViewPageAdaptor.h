//
//  TableViewPageAdaptor.h
//  DoctorClient
//
//  Created by gus on 15/8/31.
//  Copyright (c) 2015年 gus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceBlock.h"
@class TableViewPageAdaptor;
@class UIView;

typedef NSDictionary* (^PageParameterBlock)();
typedef void (^RequestFinishBlock)(id responseObjc,NSError* error);


@protocol TableViewPageAdaptorDelegate <NSObject>

@optional
-(BOOL)shouldStartRequest:(TableViewPageAdaptor*)tableViewPageAdatpor parameter:(NSDictionary*)parameter isHeader:(BOOL)isHeader;

@end

@interface TableViewPageAdaptor : NSObject
{
    
}

@property(nonatomic,strong)PageParameterBlock headerPageParameterBlock;
@property(nonatomic,strong)PageParameterBlock nextPageParameterBlock;
@property(nonatomic,strong)ResponseProcessBlock responseProcessBlock;
@property(nonatomic,strong)RequestFinishBlock requestFinishBlock;
@property(nonatomic,weak) id<TableViewPageAdaptorDelegate> delegate;

@property(nonatomic,strong)NSString* requestMethodName;
@property(nonatomic,strong)NSString* requestUrl;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,strong)UIView*emptyDataView;

-(void)registerTableView:(UITableView*)tableView elementContainer:(NSMutableArray*)elementContainer;
-(void)requestHeaderPage;
-(void)requestHeaderPage:(BOOL)showActivity;

@end
