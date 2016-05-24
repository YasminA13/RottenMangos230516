//
//  Theatre.h
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-24.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Theatre : NSObject<MKAnnotation>


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) float lat;
@property (assign, nonatomic) float lng;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;



@end
