//
//  CZNewsWithThumbnailTableViewCell.m
//  WestpacTestApp
//
//  show table cell with thumbnail
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import "CZNewsWithThumbnailTableViewCell.h"

@implementation CZNewsWithThumbnailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // set layout depends on orientation
        if ([self isPortrait]) {
            [self setupUIPortrait];
        } else {
            [self setupUILandscape];
        }
    }
    return self;
}

- (void)setupUIPortrait {
    // news thumbnail
    _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self loadImage];
    
    // news head line
    _headLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320 - 110, 20)];
    _headLineLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _headLineLabel.numberOfLines = 1;
    _headLineLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _headLineLabel.text = self.news.headLine;
    
    // news slug line
    _slugLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 320 - 110, 60)];
    _slugLineLabel.lineBreakMode = NSLineBreakByClipping;
    _slugLineLabel.numberOfLines = 3;
    _slugLineLabel.font = [UIFont systemFontOfSize:15.0];
    _slugLineLabel.textColor = [UIColor grayColor];
    _slugLineLabel.text = self.news.slugLine;
    
    [self addSubview:_thumbnailImageView];
    [self addSubview:_headLineLabel];
    [self addSubview:_slugLineLabel];
    
    [_thumbnailImageView autorelease];
    [_headLineLabel autorelease];
    [_slugLineLabel autorelease];
}

- (void)setupUILandscape {
    // news thumbnail
    _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self loadImage];
    
    // news head line
    _headLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 568 - 110, 20)];
    _headLineLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _headLineLabel.numberOfLines = 1;
    _headLineLabel.font = [UIFont boldSystemFontOfSize:17.0];
    _headLineLabel.text = self.news.headLine;
    
    // news slug line
    _slugLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 568 - 110, 60)];
    _slugLineLabel.lineBreakMode = NSLineBreakByClipping;
    _slugLineLabel.numberOfLines = 3;
    _slugLineLabel.font = [UIFont systemFontOfSize:15.0];
    _slugLineLabel.textColor = [UIColor grayColor];
    _slugLineLabel.text = self.news.slugLine;
    
    [self addSubview:_thumbnailImageView];
    [self addSubview:_headLineLabel];
    [self addSubview:_slugLineLabel];
    
    [_thumbnailImageView autorelease];
    [_headLineLabel autorelease];
    [_slugLineLabel autorelease];
}

- (void)viewWillLayoutSubviews {
    [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    if ([self isPortrait]) {
        [self setupUIPortrait];
    } else {
        [self setupUILandscape];
    }
}

- (BOOL)isPortrait {
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationLandscapeLeft && [UIDevice currentDevice].orientation != UIDeviceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}

- (void)setNews:(CZNews *)news {
    if (_news != news) {
        [news retain];
        [_news release];
        _news = news;
        [self loadImage];
        self.headLineLabel.text = self.news.headLine;
        self.slugLineLabel.text = self.news.slugLine;
    }
}

// load image asynchronously
- (void)loadImage {
    if (self.news.thumbnailImageHref) {
        // url to fetch data
        NSURL *url = [NSURL URLWithString:[self.news.thumbnailImageHref stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // fetch data via URL request
        NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // show error msg
                                       NSLog(@"error=%@", error.description);
                                   } else {
                                       if (data) {
                                           self.thumbnailImageView.image = [UIImage imageWithData:data];
                                       }
                                   }
                               }];
    }
}
@end
