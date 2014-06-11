//
//  movieListViewController.m
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/7/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "DejalActivityView.h"
#import "MovieModel.h"

@interface MovieListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;

@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
@property UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSArray* movies;
@property (strong, nonatomic) NSArray* topMovies;
@property (strong, nonatomic) NSArray* upcomingMovies;
@property (strong, nonatomic) NSArray* openingMovies;

@property UIBarButtonItem *rightButton;
@property UIBarButtonItem *leftButton;

@end

@implementation MovieListViewController

__weak MovieListViewController *weakSelf;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    weakSelf = self;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 0, 0)];
    [self.moviesTableView addSubview:refreshView];

    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading Upcoming Movies..."];
    [refreshView addSubview:self.refreshControl];

    self.moviesTableView.dataSource = self;
    self.moviesTableView.rowHeight = 110;

    [self.moviesTableView setSeparatorInset:UIEdgeInsetsZero];
    
    [self.moviesTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:(@"MovieCell")];
    
    NSString *topBoxOfficeURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=kb4nmzm3r922wednnyknd2mt&limit=10";
    getMovies(topBoxOfficeURL, 0);

    // Do any additional setup after loading the view from its nib.
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"New Arrivals" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
    
    self.leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton:)];
    
}

void (^setMovies)(NSInteger btnType, NSArray *movieArr) = ^void(NSInteger btnType, NSArray *movieArr){
    
    weakSelf.movies = [MovieModel moviesWithArray:movieArr];
    [weakSelf.moviesTableView reloadData];
    weakSelf.moviesTableView.hidden = NO;
    weakSelf.navigationItem.rightBarButtonItem=nil;
    if(btnType == 1 || btnType == 2){
        weakSelf.navigationItem.leftBarButtonItem=weakSelf.leftButton;
        if(btnType == 1){
            weakSelf.navigationItem.title = @"New Arrivals";
            weakSelf.openingMovies = movieArr;
        } else {
            weakSelf.navigationItem.title = @"Coming Soon";
            weakSelf.upcomingMovies = movieArr;
        }
    } else {
        weakSelf.navigationItem.title = @"Top 10";
        weakSelf.navigationItem.leftBarButtonItem = nil;
        weakSelf.navigationItem.rightBarButtonItem = weakSelf.rightButton;
        weakSelf.topMovies = movieArr;
    }
};

void (^getMovies)(NSString *url, NSInteger btnType) = ^void(NSString *url, NSInteger btnType){
    
    weakSelf.moviesTableView.hidden = YES;
    [DejalActivityView activityViewForView:weakSelf.view withLabel:@"Loading Movies..."];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.navigationController.view animated:YES];
        if (connectionError)
        {           // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"Network Error! Try Again...";
            hud.margin = 10.f;
            hud.yOffset = -150.f;
            hud.removeFromSuperViewOnHide = YES;
            NSLog(@"ERROR CONNECTING DATA FROM SERVER: %@", connectionError.localizedDescription);
        } else {
            /*
             NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movieDump" ofType:@"json"];
             NSData *fdata = [NSData dataWithContentsOfFile:filePath];
             id object = [NSJSONSerialization JSONObjectWithData:fdata options:kNilOptions error:nil];
             //  self.movies = object[@"movies"];
             */
            [hud hide:YES];
            [DejalActivityView removeView];
            id moviesObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            setMovies(btnType, moviesObject[@"movies"]);
        }
    }];
};

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    self.topMovies = self.movies;
    
    if(self.upcomingMovies.count == 0) {
        NSString *upcomingURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json?apikey=kb4nmzm3r922wednnyknd2mt&limit=10";
        getMovies(upcomingURL, 2);
    } else {
        setMovies(2, self.upcomingMovies);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [_moviesTableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    MovieModel *movieModel = self.movies[indexPath.row];
    NSURL *posterUrl = movieModel.posterUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:posterUrl];
    __weak MovieCell *weakMovieCell = movieCell;
    movieCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [movieCell.posterImg setImageWithURLRequest:request
                               placeholderImage:nil
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          weakMovieCell.posterImg.image = image;
                                            [weakMovieCell setNeedsLayout];
                                        } failure:nil];
    movieCell.titleLbl.text = movieModel.title;
    movieCell.criticsRLbl.text = movieModel.criticRating;
    movieCell.crowdRLbl.text = movieModel.crowdRating;
    
    return movieCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    MovieModel *movieModel = self.movies[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MovieViewController *mvc = [[MovieViewController alloc] init];
    mvc.selectedMovie = movieModel;
    [self.navigationController pushViewController:mvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLeftButton:(id)sender {
    self.movies = self.topMovies;
    [self.moviesTableView reloadData];
    self.navigationItem.title = @"Top 10";
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.rightBarButtonItem=self.rightButton;
}


- (IBAction)onRightButton:(id)sender {
    self.topMovies = self.movies;
    NSString *openingURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json?apikey=kb4nmzm3r922wednnyknd2mt&limit=10";
    if(self.openingMovies.count == 0) {
        getMovies(openingURL, 1);
    } else {
        setMovies(1, self.openingMovies);
    }
}

@end
