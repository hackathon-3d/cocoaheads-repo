//
//  LabelCollectionViewCell.m
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@interface LabelCollectionViewCell ()


@end

@implementation LabelCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPointSize:(CGFloat)pointSize
{
    _pointSize = pointSize;
    
    [self.label setFont:[self.label.font fontWithSize:self.pointSize]];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        [_label setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
        [_label setBackgroundColor:[UIColor clearColor]];
        
        [_label setAdjustsFontSizeToFitWidth:YES];
        [_label setAdjustsLetterSpacingToFitWidth:YES];
        [_label setMinimumScaleFactor:0.25];
        
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setTextColor:[UIColor whiteColor]];
        
        [_label setFont:[UIFont boldSystemFontOfSize:14.0]];
                
        [self.contentView addSubview:_label];
    }
    
    return _label;
}

@end
