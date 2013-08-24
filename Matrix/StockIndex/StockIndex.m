//
//  StockIndex.m
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockIndex.h"

NSString * const kStockIndexYearKey = @"StockIndexYear";
NSString * const kStockIndexReturnRateKey = @"StockIndexReturnRate";

@implementation StockIndex

- (CGFloat)portfolioForInitialValue:(CGFloat)initialValue {
    
    CGFloat investmentValue = initialValue;
    
    for (id returnRate in [self annualReturns]){
        CGFloat annualRate = [[(NSDictionary*)returnRate objectForKey:kStockIndexReturnRateKey] floatValue];
        investmentValue += investmentValue * (annualRate/100);
    }
    
    return investmentValue;
}

@end
