//
//  BuddyLocationMapVC.m
//  NeighbourFriends
//
//  Created by gus on 15/8/30.
//  Copyright (c) 2015年 gujitao. All rights reserved.
//

#import "BuddyLocationMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import "CCLocationManager.h"

@interface BuddyLocationMapVC ()<MAMapViewDelegate>
{
    
}

@property(nonatomic,strong)IBOutlet MAMapView*mapView;

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
    [self initMapView];
}

-(void)initNavigationItems
{
    UIBarButtonItem*listItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"ListPatten", nil) style:UIBarButtonItemStylePlain target:self action:@selector(listButtonClicked)];
    self.navigationItem.rightBarButtonItem = listItem;
}

-(void)initMapView
{
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.pausesLocationUpdatesAutomatically = NO;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
}

-(void)listButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
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
