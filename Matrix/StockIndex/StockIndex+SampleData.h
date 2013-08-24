//
//  StockIndex+SampleData.h
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockIndex.h"

NSString * const kStockIndexYearKey = @"StockIndexYear";
NSString * const kStockIndexReturnRateKey = @"StockIndexReturnRate";

@interface StockIndex (SampleData)

+ (NSArray *)sampleData;

@end
