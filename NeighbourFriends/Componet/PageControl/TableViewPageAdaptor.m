//
//  TableViewPageAdaptor.m
//  DoctorClient
//
//  Created by gus on 15/8/31.
//  Copyright (c) 2015年 gus. All rights reserved.
//

#import "TableViewPageAdaptor.h"
#import <UIKit/UIKit.h>


@interface TableViewPageAdaptor ()
{
    
}

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*elementController;

@end


@implementation TableViewPageAdaptor

-(instancetype)init
{
    self = [super init];
    self.pageSize = NSIntegerMax;
    return self;
}

-(void)registerTableView:(UITableView*)tableView elementContainer:(NSMutableArray*)container
{
    NSParameterAssert(tableView);
    NSParameterAssert(container);
    self.tableView=tableView;
    self.elementController = container;
    
    [self addRefreshControl];
    
    return;
}
-(void)addRefreshControl
{
    __weak TableViewPageAdaptor*weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestHeaderPage];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^
     {
         [weakSelf requestNextPage];
     }];
    //self.tableView.footer.hidden =YES;
    self.tableView.tableFooterView = self.emptyDataView;
    [self.tableView.footer endRefreshing];
    
}

-(void)requestHeaderPage:(BOOL)showActivity
{
    if (nil==self.headerPageParameterBlock)
    {
        return;
    }
    
    NSDictionary* headerPara=self.headerPageParameterBlock();
    [self requestPage:headerPara isHeader:YES showActivity:showActivity];
}
-(void)requestHeaderPage
{
    
    [self requestHeaderPage:YES];
}
-(void)requestNextPage
{
    NSDictionary*nextPageDict = self.nextPageParameterBlock();
    [self requestPage:nextPageDict isHeader:NO showActivity:YES];
}

-(void)requestPage:(NSDictionary*)pageDict isHeader:(BOOL)isHeader showActivity:(BOOL)showActivity
{
    NSParameterAssert(self.requestMethodName);
    
    
    if ((self.delegate != nil)&&[self.delegate respondsToSelector:@selector(shouldStartRequest:parameter:isHeader:)])
    {
        BOOL shouldStart = [self.delegate shouldStartRequest:self parameter:pageDict isHeader:isHeader];
        if (!shouldStart)
        {
            [self reloadRefreshControl:nil];
            return;
        }
    }
    /*
    MBProgressHUD*hud = nil;
    if (showActivity)
    {
        hud = [MBProgressHUD showMessage:NSLocalizedString(@"Loading", nil)];
    }
    
    NSMutableDictionary* pageParaDict = [pageDict mutableCopy];
    pageParaDict[KeyPageSize] = [NSString stringWithFormat:@"%li",self.pageSize];
    ResponseProcessBlock block = nil;
    if (nil == self.responseProcessBlock)
    {
        block =^(id responseObjc)
        {
            [self fireRequestFinishedBlock:responseObjc error:nil];
            
            [hud hide:YES];
            if (![ResponseUtil responseSuccess:responseObjc])
            {
                NSString* msg = [ResponseUtil responeMessage:responseObjc];
                [MBProgressHUD showError:msg];
                return ;
            }
            ElementContainer* result = [ResponseUtil elemetContainer:responseObjc];
            [self reloadRefreshControl:result];
            [self processResponseResult:result isHeader:isHeader];
   
        };
    }
    else
    {
        block = self.responseProcessBlock;
    }
    
    [RequestUtil postRequestService:self.requestUrl methodName:self.requestMethodName parameterDictionary:pageParaDict success:block fail:defaultErrorProceessBlockOnTableViewAndHud(self.tableView, hud)];
     */
}

-(void)fireRequestFinishedBlock:(id)responseObjc error:(NSError*)error
{
    if(nil!=self.requestFinishBlock)
    {
        self.requestFinishBlock(responseObjc,error);
    }

}

-(void)processResponseResult:(NSMutableArray*)result isHeader:(BOOL)isHeader
{

    NSMutableArray*resultArray = [result mutableCopy];
    if (resultArray.count==self.pageSize)
    {
        [resultArray removeLastObject];
    }
        
    if (isHeader)
    {
        [self.elementController removeAllObjects];
        [self.elementController addObjectsFromArray:resultArray];
            
    }
    else
    {
        [self.elementController addObjectsFromArray:resultArray];
    }
    
    if (self.elementController.count ==0)
    {
       self.tableView.tableFooterView = self.emptyDataView;
    }
    else
    {
        self.tableView.tableFooterView = nil;

    }
    
    [self.tableView reloadData];
}

-(void)reloadRefreshControl:(NSMutableArray*)result
{
    [self.tableView.footer endRefreshing];
    [self.tableView.header endRefreshing];
    
    if (result.count<self.pageSize)
    {
        self.tableView.footer.hidden = YES;
    }
    else
    {
        self.tableView.footer.hidden = NO;
    }
    
}









@end
