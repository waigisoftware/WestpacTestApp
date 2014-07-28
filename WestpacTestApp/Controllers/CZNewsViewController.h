//
//  CZNewsViewController.h
//  WestpacTestApp
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZNewsViewController : UIViewController <UIWebViewDelegate> {
    UIActivityIndicatorView *_activityIndicator;
    UIWebView *_webView;
}

@property(nonatomic, retain) NSString *newsTitle;
@property(nonatomic, retain) NSURL *newsUrl;

@end
