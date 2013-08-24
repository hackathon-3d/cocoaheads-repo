//
//  MatrixCollectionViewLayout.h
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatrixCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, readwrite) CGSize itemSize;
@property (nonatomic, readwrite) CGSize itemSpacing;

@property (nonatomic, readwrite) NSInteger numberOfRows;
@property (nonatomic, readwrite) NSInteger numberOfColumns;

@end
