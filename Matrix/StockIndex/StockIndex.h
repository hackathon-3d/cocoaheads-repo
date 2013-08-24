//
//  StockIndex.h
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockIndex : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) NSUInteger startYear;
@property (nonatomic) NSUInteger endYear;
@property (nonatomic, strong) NSArray *annualReturns; // array of dictionaries of annual returns


@end
