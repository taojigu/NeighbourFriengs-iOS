//
//  BuddyLocationMapVC.m
//  NeighbourFriends
//
//  Created by gus on 15/8/30.
//  Copyright (c) 2015年 gujitao. All rights reserved.
//

#import "BuddyLocationMapVC.h"

@interface BuddyLocationMapVC ()

@end

@implementation BuddyLocationMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Dispose of any resources that can be recreated.
    [self initCustomViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)initCustomViews
{
    [self initNavigationItems];
}

-(void)initNavigationItems
{
    UIBarButtonItem*listItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"ListPatten", nil) style:UIBarButtonItemStylePlain target:self action:@selector(listButtonClicked)];
    self.navigationItem.rightBarButtonItem = listItem;
}
-(void)listButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
