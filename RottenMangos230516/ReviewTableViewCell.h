//
//  ReviewTableViewCell.h
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *criticText;
@property (strong, nonatomic) IBOutlet UITextField *publicationText;
@property (strong, nonatomic) IBOutlet UITextField *reviewText;


@end
