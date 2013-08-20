//
//  MapViewController.m
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if([CLLocationManager locationServicesEnabled]){
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"位置情報サービスを利用できません");
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    [self.mapView setCenterCoordinate:coordinate animated:NO];
    
    MKCoordinateRegion zoom = self.mapView.region;
    
    zoom.span.latitudeDelta = 0.001;
    zoom.span.longitudeDelta = 0.001;
    
    [self.mapView setRegion:zoom animated:YES];
    self.mapView.showsUserLocation = TRUE;
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置情報利用不可"
                                                    message:@"位置情報の取得に失敗しました"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    
    [alert show];
}

@end
