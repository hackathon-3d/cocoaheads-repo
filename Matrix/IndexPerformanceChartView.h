//
//  IndexPerformanceChartView.h
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StockIndex;

@interface IndexPerformanceChartView : UIView

- (id)initForStockIndex:(StockIndex *)stockIndex frame:(CGRect)frame;
@property (nonatomic, strong) StockIndex *stockIndex;

@end
