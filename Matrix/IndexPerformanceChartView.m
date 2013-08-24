//
//  IndexPerformanceChartView.m
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "IndexPerformanceChartView.h"

#define Y_COORD_CONSTANT 3

@implementation IndexPerformanceChartView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSArray *performanceArray = @[[NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:26.4],
                                  [NSNumber numberWithFloat:12.5],
                                  [NSNumber numberWithFloat:23.4],
                                  [NSNumber numberWithFloat:18.7],
                                  [NSNumber numberWithFloat:34.7],
                                  [NSNumber numberWithFloat:10.2]];
    
    UIColor *lineColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -self.frame.size.height);

    int xCoordInterval = floor(self.frame.size.width / [performanceArray count]);
    
    for (int i = 0; i < [performanceArray count] - 1; i++) {
        
        CGPoint startPoint = CGPointMake(i*xCoordInterval, [[performanceArray objectAtIndex:i] floatValue] * Y_COORD_CONSTANT);
        CGPoint endPoint = CGPointMake((i+1)*xCoordInterval, [[performanceArray objectAtIndex:i + 1] floatValue] * Y_COORD_CONSTANT);

        [self draw1PxStrokeInContext:context
                          startPoint:startPoint
                            endPoint:endPoint
                               color:lineColor.CGColor];
    }
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

@end
