//
//  CZNewsGroup.m
//  WestpacTestApp
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import "CZNewsGroup.h"

@implementation CZNewsGroup

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (![[attributes valueForKeyPath:@"identifier"] isKindOfClass:[NSNull class]]) {
        _identifier = [[attributes valueForKeyPath:@"identifier"] integerValue];
    }
    if (![[attributes valueForKeyPath:@"name"] isKindOfClass:[NSNull class]]) {
        _name = [attributes valueForKeyPath:@"name"];
    }
    if (![[attributes valueForKeyPath:@"items"] isKindOfClass:[NSNull class]]) {
        _newsList = [[NSMutableArray alloc] init];
        NSMutableArray *itemDictionaryList = [attributes valueForKeyPath:@"items"];
        for (NSDictionary *values in itemDictionaryList) {
            CZNews *czNews = [[CZNews alloc] initWithAttributes:values];
            [_newsList addObject:czNews];
            [czNews release];
        }
    }
    
    [_name retain];
    [_newsList retain];
    
    return self;
}

- (void)dealloc {
    [_name release];
    [_newsList release];
    [super dealloc];
}

@end
