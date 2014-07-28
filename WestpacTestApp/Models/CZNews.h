//
//  CZNews.h
//  WestpacTestApp
//
//  This class represent a News
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNews : NSObject

@property(nonatomic) NSInteger identifier;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *headLine;
@property(nonatomic, retain) NSString *slugLine;
@property(nonatomic, retain) NSString *thumbnailImageHref;
@property(nonatomic, retain) NSString *webHref;
@property(nonatomic, retain) NSString *tinyUrl;
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, getter=isImageNews) BOOL imageNews;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
