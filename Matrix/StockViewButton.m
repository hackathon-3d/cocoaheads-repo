//
//  StockViewButton.m
//  Matrix
//
//  Created by GLYN THOMAS on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockViewButton.h"

@implementation StockViewButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) setHighlighted:(BOOL)highlighted
{
    
    self.backgroundColor = (highlighted)?[[UIColor blackColor] colorWithAlphaComponent:.25]:[UIColor clearColor];
}

@end
