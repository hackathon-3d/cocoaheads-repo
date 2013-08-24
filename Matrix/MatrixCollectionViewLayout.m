//
//  MatrixCollectionViewLayout.m
//  Matrix
//
//  Created by Ryan Poolos on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "MatrixCollectionViewLayout.h"

@interface MatrixCollectionViewLayout ()
{
    NSMutableArray *cachedLayoutAttributes;
}

@end

@implementation MatrixCollectionViewLayout

- (void)prepareLayout
{
    NSInteger item = 0;
    
    cachedLayoutAttributes = [NSMutableArray array];
    
    for (int x = 0; x < self.numberOfColumns; x++) {
        for (int y = 0; y < self.numberOfRows; y++) {
            if (x <= y) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item++ inSection:0];
                
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
                [attributes setFrame:CGRectMake((self.itemSpacing.width + self.itemSize.width) * x, (self.itemSpacing.height + self.itemSize.height) * y, self.itemSize.width, self.itemSize.height)];
                
                [cachedLayoutAttributes addObject:attributes];
            }
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
        
    for (UICollectionViewLayoutAttributes *attributes in cachedLayoutAttributes) {
        if (CGRectContainsRect(rect, attributes.frame)) {
            [layoutAttributes addObject:attributes];
        }
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return cachedLayoutAttributes[indexPath.item];
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake((self.itemSize.width + self.itemSpacing.width) * self.numberOfColumns,
                      (self.itemSize.height + self.itemSpacing.height) * self.numberOfRows);
}

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setItemSpacing:(CGSize)itemSpacing
{
    _itemSpacing = itemSpacing;
    
    [self invalidateLayout];
}

- (void)setNumberOfRows:(NSInteger)numberOfRows
{
    _numberOfRows = numberOfRows;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}

@end
