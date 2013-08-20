//
//  MapViewController.h
//  calendar
//
//  Created by tanaka on 2013/06/05.
//  Copyright (c) 2013年 tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, strong)IBOutlet MKMapView *mapView;
@property (nonatomic, retain)CLLocationManager *locationManager;

@end
