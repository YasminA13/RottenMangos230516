//
//  MapViewController.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-24.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "MapViewController.h"
#import "Theatre.h"
#import "DetailViewController.h"


@import CoreLocation;
@import MapKit;

@interface MapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL shouldZoomToUserLocation;
@property NSMutableArray *objects;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 0;
        
        if ([CLLocationManager authorizationStatus] ==
            kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
        }

    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D userCoordinate = location.coordinate;
    NSLog(@"lat: %f, lng: %f", userCoordinate.latitude, userCoordinate.longitude);
    
    if (!self.shouldZoomToUserLocation) {
        self.shouldZoomToUserLocation = YES;
        
        MKCoordinateRegion userRegion = MKCoordinateRegionMake(userCoordinate, MKCoordinateSpanMake(0.025, 0.025));
        [self.mapView setRegion:userRegion animated:YES];
        
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            NSLog(@"Reverse Geocode: %@", placemarks);
            
            CLPlacemark *placemark = placemarks[0];
            NSLog(@"%@", placemark.postalCode);
            
            [self addTheatreLocations:placemark.postalCode];
        }];
    }
}


- (void)addTheatreLocations:(NSString*)postalCode {
    
    self.movie.title = [self.movie.title stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    postalCode = [postalCode stringByReplacingOccurrencesOfString:@" " withString:@"%20"]; 
    NSLog(@"%@", self.movie.title);
    NSString *finalLocation = [NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@",postalCode, self.movie.title];
   
    
    
    NSURL *theatreURL = [NSURL URLWithString:finalLocation];
    
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:theatreURL];
    
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *apiTask = [sharedSession dataTaskWithRequest:apiRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *jsonError;
            
            NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError)
            {
                NSLog(@"%@", parsedData);
                
                NSMutableArray *theatreArray = [NSMutableArray array];
                
                for (NSDictionary *theatreDict in parsedData[@"theatres"]) {
                    Theatre *theatre = [[Theatre alloc] init];
                    
                    NSLog(@"%@ at %@", theatreDict[@"name"], theatreDict[@"address"]);
                    
                    theatre.name = theatreDict[@"name"];
                    theatre.address = theatreDict[@"address"];
                    theatre.lat = [theatreDict[@"lat"]floatValue];
                    theatre.lng = [theatreDict[@"lng"]floatValue];
                    theatre.coordinate = CLLocationCoordinate2DMake(theatre.lat, theatre.lng);
                    
                    [theatreArray addObject:theatre];
                }
//              self.objects = [[NSMutableArray alloc]init];
                self.objects = theatreArray;
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    for (Theatre *localTheatre in theatreArray) {
                        [self.mapView addAnnotation:localTheatre];
                    }
                   
                });
                
            } else {
                NSLog(@"Error parsing JSON: %@", [jsonError localizedDescription]);
            }
            
            
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }];

    [apiTask resume]; 
    
}









#pragma mark - CLLocationManagerDelegate



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusDenied){
        NSLog(@"Enjoy Netflix!");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error getting location: %@", [error localizedDescription]);
}



#pragma mark - MKMapViewDelegate


//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    if (annotation == mapView.userLocation) {
//        return nil;
//    }
//    
//    MKAnnotationView *theatrePin = [mapView dequeueReusableAnnotationViewWithIdentifier:@"ShowMap"];
//    if (!theatrePin) {
//        theatrePin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ShowMap"];
//        theatrePin.image = [UIImage imageNamed:@"bikeStation.png"];
//        theatrePin.centerOffset = CGPointMake(0, -bikePin.image.size.height / 2);
//    }
//    
//    return bikePin;
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
