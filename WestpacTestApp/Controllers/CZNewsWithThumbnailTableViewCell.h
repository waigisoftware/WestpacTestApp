//
//  CZNewsWithThumbnailTableViewCell.h
//  WestpacTestApp
//
//  show table cell with thumbnail
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZNews.h"

@interface CZNewsWithThumbnailTableViewCell : UITableViewCell

@property(nonatomic, retain) CZNews *news;
@property(nonatomic, retain) UIImageView *thumbnailImageView;
@property(nonatomic, retain) UILabel *headLineLabel;
@property(nonatomic, retain) UILabel *slugLineLabel;

@end
