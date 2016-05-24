//
//  Movie.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithMovieID:(NSString *)movieID title:(NSString *)title releaseDate:(NSString *)releaseDate rating:(NSNumber*)rating thumbnailURL:(NSString *)thumbnailURL andAlternativeInfo:(NSString *)alterantiveInfo{
    
    self = [super init];
    if (self) {
        _movieID = movieID;
        _title = title;
        _releaseDate = releaseDate;
        _rating = rating;
        _thumbnailURL = thumbnailURL;
        _alternativeInfo = alterantiveInfo;
    }
    
    return self;
}


@end
