//
//  ViewController.h
//  NewsApp
//
//  Created by Student on 10.12.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property NSDictionary *newsDict;
@property NSMutableArray *imgs;

@end

