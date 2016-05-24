//
//  DetailViewController.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "DetailViewController.h"
#import "ReviewTableViewController.h"
#import "Review.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    
//    
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//            
//        // Update the view.
//        [self configureView];
//    }
}

//- (void)configureView {
//    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        if (self.movie) {
            
            self.titleDetailsLabel.text = self.movie.title;
            self.releaseDetailLabel.text = [NSString stringWithFormat:@"Release Date: %@", self.movie.releaseDate];
            self.ratingDetailLabel.text = [NSString stringWithFormat:@"Audience Rating: %@",[self.movie.rating stringValue]];
            self.alternateDetailLabel.text = [NSString stringWithFormat:@"More Info: %@", self.movie.alternativeInfo];
            
            NSURL *url = [NSURL URLWithString:self.movie.thumbnailURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc] initWithData:data];
            self.posterDetailImage.image = image;
            
        }
    
    
    //[self configureView];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ReviewDetail"]) {
        
        ReviewTableViewController *rvtController = (ReviewTableViewController *)[segue destinationViewController];
        [rvtController setMovieReview:self.movie.movieReview];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
