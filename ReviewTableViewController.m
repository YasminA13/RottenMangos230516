//
//  ReviewTableViewController.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "ReviewTableViewController.h"
#import "Review.h"
#import "ReviewTableViewCell.h"


@interface ReviewTableViewController ()

@property NSMutableArray *reviewObjects;

@end

@implementation ReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *reviewURL = [NSURL URLWithString:[self.movieReview stringByAppendingString:@"?apikey=xe4xau69pxaah5tmuryvrw75"]];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:reviewURL];
    
    NSLog(@"Review URL: %@", apiRequest);
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *apiTask = [sharedSession dataTaskWithRequest:apiRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *jsonError;
            
            NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError)
            {
                NSLog(@"%@", parsedData);
                
                NSMutableArray *reviewsArray = [NSMutableArray array];
                
                for (NSDictionary *reviewDict in parsedData[@"reviews"]) {
                    Review *review = [[Review alloc] init];
                    
                    review.critic = reviewDict[@"critic"];
                    review.publication = reviewDict[@"publication"];
                    review.review = reviewDict[@"quote"];
                    
                    [reviewsArray addObject:review];
                }
                
                self.reviewObjects = reviewsArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.reviewObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.reviewObjects.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
    
    Review *review = self.reviewObjects[indexPath.row];
    cell.criticText.text = [review critic];
    cell.publicationText.text = [review publication];
    cell.reviewText.text = [review review];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
