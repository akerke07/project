//
//  InfoTableViewCell.h
//  NewsApp
//
//  Created by Student on 10.12.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *newsNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsCatLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@end
