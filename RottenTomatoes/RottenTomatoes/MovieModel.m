//
//  MovieInfo.m
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/10/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import "MovieModel.h"


@implementation MovieModel : NSObject 

- (id)initWithDictionary:(NSDictionary *)movie {
    self = [super init];
    if (self) {
        self.title = movie[@"title"];
        self.synopsis = movie[@"synopsis"];
        self.crowdRating = [NSString stringWithFormat:@"%@%%", movie[@"ratings"][@"audience_score"]];
        self.criticRating = [NSString stringWithFormat:@"%@%%", movie[@"ratings"][@"critics_score"]];
        self.posterUrl = [NSURL URLWithString:movie[@"posters"][@"profile"]];
        self.bigPosterUrl = [NSURL URLWithString:movie[@"posters"][@"original"]];
    }
    
    return self;
}

+ (NSArray *)moviesWithArray:(NSArray *)array {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        MovieModel *movie = [[MovieModel alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    
    return movies;
}
@end
