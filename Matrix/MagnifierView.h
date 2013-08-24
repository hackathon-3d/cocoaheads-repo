//
//  MagnifierView.h
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagnifierView : UIView

@property (nonatomic, strong) UIScrollView *sourceView;

@property (nonatomic, readwrite) CGPoint touchPoint;

@end
