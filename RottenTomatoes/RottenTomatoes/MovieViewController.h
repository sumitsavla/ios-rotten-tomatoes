//
//  tViewController.h
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/10/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieViewController : UIViewController

@property (strong, nonatomic, readwrite) MovieModel* selectedMovie;

@end
