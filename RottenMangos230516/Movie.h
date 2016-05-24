//
//  Movie.h
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *movieReview;
@property (nonatomic, copy) NSString *movieID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSNumber *rating;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, copy) NSString *alternativeInfo;

-(instancetype)initWithMovieID:(NSString*)movieID title:(NSString*)title releaseDate:(NSNumber*)releaseDate rating:(NSString*)rating thumbnailURL:(NSString*)thumbnailURL andAlternativeInfo:(NSString*)alterantiveInfo;

@end
