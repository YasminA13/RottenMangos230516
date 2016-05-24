//
//  Review.h
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (strong, nonatomic) NSString *critic;
@property (strong, nonatomic) NSString *publication;
@property (strong, nonatomic) NSString *review;

-(instancetype)initWithCritic:(NSString*)critic publication:(NSString *)publication andReview:(NSString*)review;


@end
