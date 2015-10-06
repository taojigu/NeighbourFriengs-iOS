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
#import <CoreLocation/CoreLocation.h>
#import "CCLocationManager.h"
#import "LocationWrapper.h"

@interface BuddyLocationTVC ()
{
    
}

@property(nonatomic,strong)NSMutableArray*poiArray;
@property(nonatomic,assign)CLLocationCoordinate2D currentLocation;

@end

@implementation BuddyLocationTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPrivateField];
    [self initCustomViews];
    
    [self requestBuddyPoiArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initPrivateField
{
    self.poiArray = [NSMutableArray array];
}
-(void)initCustomViews
{
    [self initSearchController];
    [self initNavigationItem];
}

-(void)requestBuddyPoiArray
{
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        
        double lat = locationCorrrdinate.latitude;
        double longtitude = locationCorrrdinate.longitude;
        self.currentLocation = locationCorrrdinate;
        
        self.poiArray = [self samplePoiArray:lat longtitude:longtitude];
        
        [self.tableView reloadData];
        
    }];
}
-(NSMutableArray*)samplePoiArray:(double)latitude longtitude:(double)longtitude
{
    NSMutableArray*array =[NSMutableArray array];
    for (NSInteger poiIndex = 0; poiIndex<10; poiIndex++)
    {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        double rdmLati = (50-random()%100)*0.001+latitude;
        double rdmLong = (50-random()%100)*0.001+longtitude;
        dict[KeyPoiName] = [NSString stringWithFormat:@"Poi%li",poiIndex];
        dict[KeyPoiType] = @"Home";
        dict[KeyPoiDistance] = @"100";
        dict[KeyPoiLatitude] = [NSNumber numberWithDouble:rdmLati];
        dict[KeyPoiLongtitude] = [NSNumber numberWithDouble:rdmLong];
        dict[KeyPoiAddress] = @"Address in beijing";
        dict[KeyProfileImageUrl] = @"http://www.lanrentuku.com/down/png/0904/Mario_Galaxy/Mario_Galaxy_002.png";
        
        [array addObject:dict];
        
    }
    
    return array;
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
    mapvc.poiArray = self.poiArray;
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
    return self.poiArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuddyLocationCell *cell = (BuddyLocationCell*)[tableView dequeueReusableCellWithIdentifier:@"BuddyLocationCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSMutableDictionary* dict = [self.poiArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = dict[KeyPoiName];
    
    NSNumber*latNumber = dict[KeyPoiLatitude];
    NSNumber*longNumber = dict[KeyPoiLongtitude];
    
    NSString*distText = [[LocationWrapper sharedWrapper] distance:self.currentLocation.latitude srcLongtitude:self.currentLocation.longitude destLatitude:[latNumber doubleValue] destLongtitude:[longNumber doubleValue]];
    cell.distanceLabel.text = distText;
    cell.addressLabel.text = dict[KeyPoiAddress];
    dict[KeyPoiDistance] =  distText;
    
    
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
