//
//  CZNews.m
//  WestpacTestApp
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import "CZNews.h"

@implementation CZNews

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (![[attributes valueForKeyPath:@"identifier"] isKindOfClass:[NSNull class]]) {
        _identifier = [[attributes valueForKeyPath:@"identifier"] integerValue];
    }
    if (![[attributes valueForKeyPath:@"type"] isKindOfClass:[NSNull class]]) {
        _type = [attributes valueForKeyPath:@"type"];
    }
    if (![[attributes valueForKeyPath:@"headLine"] isKindOfClass:[NSNull class]]) {
        _headLine = [attributes valueForKeyPath:@"headLine"];
    }
    if (![[attributes valueForKeyPath:@"slugLine"] isKindOfClass:[NSNull class]]) {
        _slugLine = [attributes valueForKeyPath:@"slugLine"];
    }
    if (![[attributes valueForKeyPath:@"thumbnailImageHref"] isKindOfClass:[NSNull class]]) {
        _thumbnailImageHref = [attributes valueForKeyPath:@"thumbnailImageHref"];
    }
    if (_thumbnailImageHref != nil && ![_thumbnailImageHref isEqualToString:@"null"] && [_thumbnailImageHref length] > 0) {
        _imageNews = YES;
    } else {
        _imageNews = NO;
    }
    if (![[attributes valueForKeyPath:@"webHref"] isKindOfClass:[NSNull class]]) {
        _webHref = [attributes valueForKeyPath:@"webHref"];
    }
    if (![[attributes valueForKeyPath:@"tinyUrl"] isKindOfClass:[NSNull class]]) {
        _tinyUrl = [attributes valueForKeyPath:@"tinyUrl"];
    }
    if (![[attributes valueForKeyPath:@"dateLine"] isKindOfClass:[NSNull class]]) {
        // cache the formatter for Efficiency
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
            dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_AU"];
            _date = [dateFormatter dateFromString:[attributes valueForKeyPath:@"dateLine"]];
        }
    }
    
    [_type retain];
    [_headLine retain];
    [_slugLine retain];
    [_thumbnailImageHref retain];
    [_webHref retain];
    [_tinyUrl retain];
    [_date retain];
    
    return self;
}

- (void)dealloc {
    [_type release];
    [_headLine release];
    [_slugLine release];
    [_thumbnailImageHref release];
    [_webHref release];
    [_tinyUrl release];
    [_date release];
    [super dealloc];
}

@end
