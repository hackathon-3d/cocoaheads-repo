//
//  MagnifierView.m
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "MagnifierView.h"

@implementation MagnifierView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
        
        [self.layer setMasksToBounds:YES];
        
        [self.layer setCornerRadius:(CGRectGetWidth(frame) / 2.0)];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:3.0];
        
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
        [self.layer setShadowOpacity:0.75];
        [self.layer setShadowRadius:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    CGContextScaleCTM(context, 1.25, 1.25);
    
    CGContextTranslateCTM(context, -self.sourceView.contentOffset.x, -self.sourceView.contentOffset.x);
    
    CGPoint touchPoint = [self.sourceView convertPoint:self.center fromView:self.superview];
    
    CGContextTranslateCTM(context, -(touchPoint.x - 64.0), -(touchPoint.y + 24.0));
    
//    UIBezierPath *clippingPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
//    [clippingPath addClip];
    
    [self.sourceView.layer renderInContext:context];
    
    
    CGContextRestoreGState(context);
}

@end
