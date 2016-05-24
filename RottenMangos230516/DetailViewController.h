//
//  DetailViewController.h
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "ReviewTableViewCell.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) IBOutlet UILabel *titleDetailsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *posterDetailImage;
@property (strong, nonatomic) IBOutlet UILabel *releaseDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *alternateDetailLabel;
@property (strong, nonatomic) IBOutlet UIButton *reviewButton;

@end

