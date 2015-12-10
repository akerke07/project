//
//  ViewController.m
//  NewsApp
//
//  Created by Student on 10.12.15.
//  Copyright (c) 2015 Student. All rights reserved.
//

#import "ViewController.h"
#import "InfoTableViewCell.h"
#import "News.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIImage *img;
@end

@implementation ViewController

NSString *post;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*[self callRequestAsyncWithURL:@"http://api.royal.kz/soc/news" andWithUIREpresentBlock:^void(NSMutableArray* newsDict){
        [self makeGetRequest];
    }];*/
    //NSMutableArray *imgs = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
       [self makeGetRequest];
        self.imgs = [NSMutableArray new];
        for(int i = 0; i < [[self.newsDict objectForKey:@"models"]count];i++ ){
           // NSString *hash = [[[self.newsDict objectForKey:@"models"]objectAtIndex:i] objectForKey:@"news_image_file"];
            
           // NSString *urlPath = @"http://fs.royal.kz/640x480xc/";
          //  NSString *urlString = [urlPath stringByAppendingString:hash];
            
            
             [self.imgs addObject:[NSString stringWithFormat:@"%@%@", @"http://fs.royal.kz/640x480xc/", [[[self.newsDict objectForKey:@"models"]objectAtIndex:i] objectForKey:@"news_image_file"]]];
            //NSURL *url = [NSURL URLWithString:];
            
           // NSData *data = [NSData dataWithContentsOfURL:url];
            
           // [self.imgs addObject:data];
            
            
        }
        NSLog(@"%lu", self.imgs.count);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
         [self.tableView reloadData];
            
        });
    });
}
- (void)callRequestAsyncWithURL:(NSString*)url andWithUIREpresentBlock:(void(^)(NSMutableArray *newsDict))block{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    
    //Create and add the Activity Indicator to splashView
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    activityIndicator.hidesWhenStopped = NO;
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    [self.view addSubview:view];
   /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        self.newsArr = [self makeGetRequest];
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            block(self.newsArr);
            [view removeFromSuperview];
            
        });
    });*/
}
-(void)makeGetRequest {
     NSMutableArray *result = [NSMutableArray new];
    // Send a synchronous request
    NSURLRequest *getRequest= [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.royal.kz/soc/news"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:getRequest
                                          returningResponse:&response
                                                      error:&error];
    
    result = [NSMutableArray new];
    self.newsDict = [NSDictionary new];
    if (error == nil)
    {
        NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"OUTPUT- %@", dataString);
        //parsing
       self.newsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@", self.newsDict);
        
        
    }
    else{
        
        NSLog(@"error=  %@", error);
        
        return;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = (InfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accountLabel.text = [[[self.newsDict objectForKey:@"models"]objectAtIndex:indexPath.row] objectForKey:@"account_fullname"];
    [cell.accountLabel setTextColor:[UIColor greenColor]];
    cell.newsTitle.text = [[[self.newsDict objectForKey:@"models"]objectAtIndex:indexPath.row] objectForKey:@"news_title"];
    [cell.newsTitle setTextColor:[UIColor blueColor]];
    cell.newsDateLabel.text = [[[self.newsDict objectForKey:@"models"]objectAtIndex:indexPath.row] objectForKey:@"news_created_date"];
    cell.newsCatLabel.text = [[[self.newsDict objectForKey:@"models"]objectAtIndex:indexPath.row] objectForKey:@"news_cat"];
    
    //[cell.imageView setImage:image];
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.imgs objectAtIndex:indexPath.row]]];
   // [cell.imageView setImage:[UIImage imageWithData:data]];
    [cell.imageView setImage: [UIImage imageWithData:data]];
   // [cell.imageView.sizeToFit];
    CGSize size=CGSizeMake(50, 63);//set the width and height
    //UIImage resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.newsDict objectForKey:@"models"]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
