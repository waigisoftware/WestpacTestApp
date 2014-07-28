//
//  CZNewsViewController.m
//  WestpacTestApp
//
//  display a single news as web page
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import "CZNewsViewController.h"

@interface CZNewsViewController ()

@end

@implementation CZNewsViewController

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
    // Do any additional setup after loading the view.
    
    // set title
    self.title = self.newsTitle;
    
    CGRect frame = [self.view bounds];
    
    // create web view to show news
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height + frame.origin.y)];
    _webView.opaque = YES; // make sure it's set to opaque = YES for better performance
    [_webView setDelegate:self];
    [self.view addSubview:_webView];
    
    // create activityIndicator
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    [self.view addSubview:_activityIndicator];
    
    // load web page
    [_webView loadRequest:[NSURLRequest requestWithURL:self.newsUrl]];
    
    [_webView autorelease];
}

- (void)setupUI {
    CGRect frame = [self.view bounds];
    _activityIndicator.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    _webView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height + frame.origin.y);
}

- (void)viewWillLayoutSubviews {
    [self setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_activityIndicator release];
    [super dealloc];
}

#pragma mark - UIWebViewDelegate, show/hide activity indicator

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_activityIndicator stopAnimating];
}

@end
