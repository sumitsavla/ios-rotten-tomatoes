//
//  MovieInfo.h
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/10/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic) NSURL *posterUrl;
@property (nonatomic) NSString *crowdRating;
@property (nonatomic) NSString *criticRating;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithArray:(NSArray *)array;

@end
