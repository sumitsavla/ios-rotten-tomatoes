//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Savla, Sumit on 6/7/14.
//  Copyright (c) 2014 Sumit Savla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *criticsRLbl;
@property (weak, nonatomic) IBOutlet UILabel *crowdRLbl;

@end
