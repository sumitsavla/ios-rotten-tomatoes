//
//  tViewController.m
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/10/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation MovieViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.pagingEnabled = YES;
    CGFloat xOrigin = 0;
    UILabel *lblView = [[UILabel alloc] initWithFrame:CGRectMake(xOrigin, -60, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.75];
    lblView.text = self.selectedMovie.synopsis;
    lblView.lineBreakMode = NSLineBreakByWordWrapping;
    lblView.textColor = [UIColor whiteColor];
    lblView.numberOfLines = 0;
    lblView.backgroundColor=[UIColor clearColor];
    
    [scroll addSubview:lblView];
    scroll.contentSize = CGSizeMake(0, 900);
    [self.view addSubview:scroll];
    
    self.navigationItem.title = self.selectedMovie.title;
    
    NSURL *posterUrl = self.selectedMovie.bigPosterUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:posterUrl];
    [self.img setImageWithURLRequest:request
                    placeholderImage:nil
                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                 self.img.image = image;
                             } failure:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
