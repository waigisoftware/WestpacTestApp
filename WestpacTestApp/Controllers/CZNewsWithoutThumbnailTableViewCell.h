//
//  CZNewsWithoutThumbnailTableViewCell.h
//  WestpacTestApp
//
//  show table cell without thumbnail
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZNews.h"

@interface CZNewsWithoutThumbnailTableViewCell : UITableViewCell

@property(nonatomic, retain) CZNews *news;
@property(nonatomic, retain) UILabel *headLineLabel;
@property(nonatomic, retain) UILabel *slugLineLabel;

@end