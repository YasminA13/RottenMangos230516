//
//  MasterViewController.m
//  RottenMangos230516
//
//  Created by Yasmin Ahmad on 2016-05-23.
//  Copyright © 2016 YasminA. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Movie.h"


@interface MasterViewController ()

@property NSMutableArray *objects; //data source driving table view

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSURL *movieURL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=xe4xau69pxaah5tmuryvrw75"];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:movieURL];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    //one instance
    //creates one session that is reused
    //has a list of all requests from url 'apiRequest'

    //kicks off the request
    NSURLSessionDataTask *apiTask = [sharedSession dataTaskWithRequest:apiRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSLog(@"completed response");
        
        if (!error) {
            NSError *jsonError;
            
            NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            //taking Data from NSData and parsing from JSON to NSDictionary
            
            if (!jsonError)//didn't get an error parsing from JSON.Valid continue and turn into NSDictionary
            {
                NSLog(@"%@", parsedData);
                
                NSMutableArray *moviesArray = [NSMutableArray array];
                
                for (NSDictionary *movieDict in parsedData[@"movies"]) {
                    Movie *movie = [[Movie alloc] init];
                    //use custom initializer on movie
                    
                    //parsed data is root object which contains an array at the key movies
                    //this array contains info on id, title, release date, etc. (each element)
                                        
                    movie.movieID = movieDict[@"id"];
                    movie.title = movieDict[@"title"];
                    movie.releaseDate = movieDict[@"release_dates"][@"theater"];
                    movie.rating = movieDict[@"ratings"][@"audience_score"];
                    movie.thumbnailURL = movieDict[@"posters"][@"thumbnail"];
                    movie.alternativeInfo = movieDict[@"links"][@"alternate"];
                    movie.movieReview = movieDict[@"links"][@"reviews"];
                    
                    [moviesArray addObject:movie];
                }
                
                self.objects = moviesArray;
                
                //command to bring back to foreground and to update UI
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
    
    //start!
    [apiTask resume];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setMovie:movie];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Movie *movie = self.objects[indexPath.row];
    cell.textLabel.text = movie.title;
    return cell;
}


@end
