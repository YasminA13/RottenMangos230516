//
//  Review.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "Review.h"

@implementation Review

-(instancetype)initWithCritic:(NSString*)critic publication:(NSString *)publication andReview:(NSString *)review{
    
    self = [super init];
    if (self) {
        _critic = critic;
        _publication = publication;
        _review = review;
    }

    return self; 
}

@end
