//
//  LabelCollectionViewCell.h
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelCollectionViewCell : UICollectionViewCell

@property (nonatomic, readwrite) CGFloat pointSize;

@property (nonatomic, strong) UILabel *label;

@end
