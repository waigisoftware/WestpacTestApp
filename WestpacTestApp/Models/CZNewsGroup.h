//
//  CZNewsGroup.h
//  WestpacTestApp
//
//  This class group News of the same type
//
//  Created by Can on 28/07/2014.
//  Copyright (c) 2014 CanZhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZNews.h"

@interface CZNewsGroup : NSObject

@property(nonatomic) NSInteger identifier;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSMutableArray *newsList;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
