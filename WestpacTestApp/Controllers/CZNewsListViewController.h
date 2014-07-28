//
//  CZNewsListViewController.h
//  WestpacTestApp
//
//  The View Controller shows news list
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZNewsGroup.h"

@interface CZNewsListViewController : UIViewController <NSURLConnectionDataDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray *_newsList;
    UITableView *_tableView;
    UIActivityIndicatorView *_activityIndicator;
}

@property (nonatomic, retain) CZNewsGroup *newsGroup;

@end
