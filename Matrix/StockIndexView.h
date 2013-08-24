//
//  IndexReturnChartView.h
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StockIndex;

@interface StockIndexView : UIView

@property (nonatomic, strong) StockIndex *stockIndex;
- (id)initForStockIndex:(StockIndex *)stockIndex frame:(CGRect)frame;

@end
