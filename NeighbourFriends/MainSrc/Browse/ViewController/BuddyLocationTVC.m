//
//  BuddyLocationTVC.m
//  NeighbourFriends
//
//  Created by gus on 15/8/30.
//  Copyright (c) 2015年 gujitao. All rights reserved.
//

#import "BuddyLocationTVC.h"
#import "BuddyLocationCell.h"
#import "BuddyLocationMapVC.h"

@interface BuddyLocationTVC ()

@end

@implementation BuddyLocationTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initCustomViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initCustomViews
{
    [self initSearchController];
    [self initNavigationItem];
}

-(void)initNavigationItem
{
    UIBarButtonItem*mapItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"MapPatten", nil) style:UIBarButtonItemStylePlain target:self action:@selector(mapButtonClicked)];
    self.navigationItem.rightBarButtonItem = mapItem;
}

-(void)mapButtonClicked
{
    

    BuddyLocationMapVC*mapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"BuddyLocationMapVC"];
    mapvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    //[self.navigationController pushViewController:mapvc animated:YES];
    
    UINavigationController*navi = [[UINavigationController alloc]initWithRootViewController:mapvc];
    [self presentViewController:navi animated:YES completion:nil];
}
-(void)initSearchController
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuddyLocationCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
