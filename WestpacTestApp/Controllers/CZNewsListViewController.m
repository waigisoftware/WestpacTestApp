//
//  CZNewsListViewController.m
//  WestpacTestApp
//
//  display news list
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import "CZNewsListViewController.h"
#import "CZNewsViewController.h"
#import "CZNews.h"
#import "CZNewsWithThumbnailTableViewCell.h"
#import "CZNewsWithoutThumbnailTableViewCell.h"

@interface CZNewsListViewController ()

@end

@implementation CZNewsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    // setup UI
    [self setupUI];
    
    // init data
    _newsList = [[NSArray alloc] init];
    
    // fetchData
    [self fetchData];
}

- (void)setupUI {
    CGRect frame = [self.view frame];
    
    // navigation bar
    self.navigationController.navigationBar.translucent = NO;
    
    // set title
    self.title = @"News";
    
    // add refresh button
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(fetchData)];
    self.navigationItem.leftBarButtonItem = refreshItem;
    [refreshItem autorelease];
    
    // create activityIndicator
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    [self.view addSubview:_activityIndicator];
    [_activityIndicator autorelease];
    
    // create table view
    if (iOS7) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + frame.origin.y - 64)];
    } else {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + frame.origin.y - 44)];
    }
    _tableView.opaque = YES; // make sure it's set to opaque = YES for better performance
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView autorelease];
}

- (void)viewWillLayoutSubviews {
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (_newsGroup) {
        [_newsGroup release];
    }
    [_newsList release];
    [_tableView release];
    [_activityIndicator release];
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // number of news
    return [_newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // get currently selected news
    CZNews *selectedNews = (CZNews *)[_newsList objectAtIndex:indexPath.row];
    
    if (selectedNews.isImageNews) {
        
        static NSString *CZNewsWithThumbnailCellIdentifier = @"CZNewsWithThumbnailTableViewCell";
        CZNewsWithThumbnailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CZNewsWithThumbnailCellIdentifier];
        if (cell == nil) {
            cell = [[CZNewsWithThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CZNewsWithThumbnailCellIdentifier];
        }
        
        // config cell
        cell.news = ((CZNews *)[_newsList objectAtIndex:indexPath.row]);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        
        static NSString *CZNewsWithoutThumbnailCellIdentifier = @"CZNewsWithoutThumbnailTableViewCell";
        CZNewsWithoutThumbnailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CZNewsWithoutThumbnailCellIdentifier];
        if (cell == nil) {
            cell = [[CZNewsWithoutThumbnailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CZNewsWithoutThumbnailCellIdentifier];
        }
        
        // config cell
        cell.news = ((CZNews *)[_newsList objectAtIndex:indexPath.row]);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushToNewsVCWithNews:[_newsList objectAtIndex:indexPath.row]];
}

#pragma mark - fetch JSON data and build NewsGroup instance
- (void)fetchData {
    // start activity indicator
    [_activityIndicator startAnimating];
    
    // url to fetch data
    NSURL *url = [NSURL URLWithString:[jsonSourceURLAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // fetch data via URL request
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               // stop activity indicator
                               [_activityIndicator stopAnimating];
                               
                               if (error) {
                                   // show error msg
                                   NSLog(@"error=%@", error.description);
                               } else {
                                   if (data) {
                                       // parse out the json data
                                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                       // read new group information
                                       _newsGroup = [[CZNewsGroup alloc] initWithAttributes:json];
                                       // sort news in the group by date
                                       NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
                                       NSArray *sortDescriptors = [NSArray arrayWithObjects:dateDescriptor, nil];
                                       _newsList = [[_newsGroup.newsList sortedArrayUsingDescriptors:sortDescriptors] retain];
                                       [dateDescriptor release];
                                       [_newsGroup autorelease];
                                       // refresh table view
                                       [_tableView reloadData];
                                   }
                               }
                           }];
}

#pragma mark - navigate to News Content View
- (void)pushToNewsVCWithNews:(CZNews *)news {
    // create view controller and pass url to it to load
    CZNewsViewController *newsVC = [[CZNewsViewController alloc] init];
    newsVC.newsUrl = [NSURL URLWithString:news.tinyUrl];
    newsVC.newsTitle = news.headLine;
    
    // navigate to created VC
    [self.navigationController pushViewController:newsVC animated:YES];
    [newsVC autorelease];
}

@end
