//
//  IndexPerformanceChartView.m
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockPerformanceChartView.h"
#import "StockIndex+SampleData.h"

#define INITIAL_INVESTMENT 100

@interface StockPerformanceChartView () {
    float initialInvestment;
    UIColor *chartColor;
    NSMutableArray *yearlyPortfolioValue;
}

@end

@implementation StockPerformanceChartView

- (id)initForStockIndex:(StockIndex *)stockIndex frame:(CGRect)frame {
    if ((self = [self initWithFrame:frame])){
        _stockIndex = stockIndex;
        [self calculateAnnualPortfolioValue];
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

- (void)calculateAnnualPortfolioValue {
    yearlyPortfolioValue = [NSMutableArray array];
    for (int i = 0; i < [[self.stockIndex annualReturns] count] - 1; i++) {
        CGFloat portfolioValue;
        
        NSDictionary *rorDict = (NSDictionary*)[[self.stockIndex annualReturns] objectAtIndex:i];
        CGFloat annualRate = [[(NSDictionary *)rorDict objectForKey:kStockIndexReturnRateKey] floatValue];
        if (i == 0){
            portfolioValue = INITIAL_INVESTMENT * (annualRate/100) + INITIAL_INVESTMENT;
        }else {
            portfolioValue = [[yearlyPortfolioValue objectAtIndex:i-1] floatValue] * (annualRate/100) + [[yearlyPortfolioValue objectAtIndex:i-1] floatValue];
        }
        
        [yearlyPortfolioValue insertObject:[NSNumber numberWithFloat:portfolioValue] atIndex:i];
    }
}

- (void)drawRect:(CGRect)rect {
    self.opaque = NO;
    chartColor = [UIColor whiteColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -self.frame.size.height * 1.6);

    int xCoordInterval = floor(self.frame.size.width / [[self.stockIndex annualReturns] count] - 1);
    
    CGPoint startPoint;
    CGPoint endPoint;
    for (int i = 0; i < [[self.stockIndex annualReturns] count] - 2; i++) {
        startPoint = CGPointMake(i*xCoordInterval, [[yearlyPortfolioValue objectAtIndex:i] floatValue]);
        endPoint = CGPointMake((i+1)*xCoordInterval, [[yearlyPortfolioValue objectAtIndex:i+1] floatValue]);

        [self draw1PxStrokeInContext:context
                          startPoint:startPoint
                            endPoint:endPoint
                               color:chartColor.CGColor];
    }
    [self drawPointInContext:context endPoint:endPoint color:chartColor.CGColor];
    
    initialInvestment = 100.0;
    NSString *roiString = [NSString stringWithFormat:@"$%.2f", [self.stockIndex portfolioForInitialValue:initialInvestment]];
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, chartColor.CGColor);
    CGContextTranslateCTM(context, -30, endPoint.y - 70);
    CGContextScaleCTM(context, 1.0, -1.0);
    [roiString drawAtPoint:endPoint withFont:[UIFont boldSystemFontOfSize:14.0]];
    CGContextRestoreGState(context);
}

- (void)drawPointInContext:(CGContextRef)context endPoint:(CGPoint)endPoint color:(CGColorRef)color {
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, chartColor.CGColor);
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
    [self calculateAnnualPortfolioValue];
    [self setNeedsDisplay];
}

@end
