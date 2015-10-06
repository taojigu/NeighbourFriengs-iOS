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
#import <objc/runtime.h>
#import "PoiAnnotation.h"
@interface BuddyLocationMapVC ()<MAMapViewDelegate>
{
    
}

@property(nonatomic,strong)IBOutlet MAMapView*mapView;
@property(nonatomic,strong)MAUserLocation*currentUserLocation;

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
    [self.mapView setZoomLevel:13.1 animated:YES];
    
    //[self moveToUserLocation];
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self initMapViewAnnotations];
   
}

-(void)initMapViewAnnotations
{
    for (NSDictionary* dict in self.poiArray)
    {
        PoiAnnotation*annotation = [[PoiAnnotation alloc]initWithPoiDictionary:dict];
        
        [self.mapView addAnnotation:annotation];
    }
}
-(void)moveToUserLocation
{
    MAUserLocation*location = self.mapView.userLocation;
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}
-(void)listButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {
        //[self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}


#pragma mark - Poi PinView

-(MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
    MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
    if (annotationView == nil)
    {
        annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:userLocationStyleReuseIndetifier];
    }
    annotationView.canShowCallout               = YES;
    annotationView.animatesDrop                 = YES;
    annotationView.annotation = annotation;

    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        
        
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor = MAPinAnnotationColorPurple;
        
        
    }
    return annotationView;
}

/*
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[PoiAnnotation class]])
    {
        MARouteConfig *config = [MARouteConfig new];
        config.appName = [self getApplicationName];
        config.appScheme = [self getApplicationScheme];
        config.startCoordinate = self.mapView.userLocation.coordinate;
        config.destinationCoordinate = view.annotation.coordinate;
        config.routeType = MARouteSearchTypeDriving;
        [MAMapURLSearch openAMapRouteSearch:config];
    }
    
}
 */
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MANaviConfig * config = [[MANaviConfig alloc] init];
        config.destination = view.annotation.coordinate;
        config.appScheme = [self getApplicationScheme];
        config.appName = [self getApplicationName];
        config.strategy = MADrivingStrategyShortest;
        
        if(![MAMapURLSearch openAMapNavigation:config])
        {
            [MAMapURLSearch getLatestAMapApp];
        }
    }
}

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
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
