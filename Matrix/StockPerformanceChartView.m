//
//  IndexPerformanceChartView.m
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockPerformanceChartView.h"
#import "StockIndex+SampleData.h"

#define Y_COORD_CONSTANT 3

@interface StockPerformanceChartView () {
    float initialInvestment;
}

@end

@implementation StockPerformanceChartView

- (id)initForStockIndex:(StockIndex *)stockIndex frame:(CGRect)frame {
    if ((self = [self initWithFrame:frame])){
        _stockIndex = stockIndex;
        self.opaque = NO;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.opaque = NO;

    UIColor *lineColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -self.frame.size.height);

    int xCoordInterval = floor(self.frame.size.width / [[self.stockIndex annualReturns] count] - 1);
    
    CGPoint startPoint;
    CGPoint endPoint;
    for (int i = 0; i < [[self.stockIndex annualReturns] count] - 1; i++) {
        
        NSDictionary *startRORDict = (NSDictionary*)[[self.stockIndex annualReturns] objectAtIndex:i];
        NSDictionary *endRORDict = (NSDictionary*)[[self.stockIndex annualReturns] objectAtIndex:i+1];
        startPoint = CGPointMake(i*xCoordInterval, [[startRORDict objectForKey:kStockIndexReturnRateKey] floatValue] * Y_COORD_CONSTANT);
        endPoint = CGPointMake((i+1)*xCoordInterval, [[endRORDict objectForKey:kStockIndexReturnRateKey] floatValue] * Y_COORD_CONSTANT);

        [self draw1PxStrokeInContext:context
                          startPoint:startPoint
                            endPoint:endPoint
                               color:lineColor.CGColor];
    }
    [self drawPointInContext:context endPoint:endPoint color:lineColor.CGColor];
    
    initialInvestment = 1.0;
    NSString *roiString = [NSString stringWithFormat:@"$%f", [self.stockIndex portfolioForInitialValue:initialInvestment]];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, endPoint.y+50);
    CGContextScaleCTM(context, 1.0, -1.0);
    [roiString drawAtPoint:endPoint withFont:[UIFont boldSystemFontOfSize:14.0]];
    CGContextRestoreGState(context);
}

- (void)drawPointInContext:(CGContextRef)context endPoint:(CGPoint)endPoint color:(CGColorRef)color {
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x, endPoint.y, 4, 4));
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}

- (void)draw1PxStrokeInContext:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint color:(CGColorRef)color {
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)setStockIndex:(StockIndex *)stockIndex {
    _stockIndex = stockIndex;
    [self setNeedsDisplay];
}

@end
