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
    
    CGRect hotspot = CGRectMake(self.touchPoint.x - (self.itemSize.width * 1.1), self.touchPoint.y - (self.itemSize.height * 1.1), self.itemSize.width * 3, self.itemSize.height * 3);
    
    CGRect outerSpot = CGRectInset(hotspot, -(self.itemSize.width * 2.0), -(self.itemSize.height * 2.0));
    
    for (UICollectionViewLayoutAttributes *attributes in cachedLayoutAttributes) {
        attributes.zIndex = 0;
        
        if (CGRectContainsRect(rect, attributes.frame)) {
//            float distance = sqrtf(powf(2.0, (attributes.center.x - self.touchPoint.x)) + powf(2.0, (attributes.center.y - self.touchPoint.y)));
//            distance = -distance + 2.0;
//            
//            float normal = distance;
//            
//            float scale = MAX(normal, 1.0);
//            scale = MIN(scale, 2.0);
//            
//            attributes.transform3D = CATransform3DMakeScale(scale, scale, scale);
            
            [layoutAttributes addObject:attributes];
        }
    
//        if (CGRectContainsRect(outerSpot, attributes.frame)) {
//            attributes.transform3D = CATransform3DMakeScale(1.2, 1.2, 1.2);
//            attributes.zIndex += 1;
//        }
//        
//        if (CGRectContainsRect(hotspot, attributes.frame)) {
//            attributes.transform3D = CATransform3DMakeScale(1.35, 1.35, 1.35);
//            attributes.zIndex += 1;
//        }
//        
//        if (CGRectContainsPoint(attributes.frame, self.touchPoint)) {
//            attributes.transform3D = CATransform3DMakeScale(1.5, 1.5, 1.5);
//            attributes.zIndex = 99;
//        }
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

#pragma mark - Hot Spot Maginifier

- (void)setTouchPoint:(CGPoint)touchPoint
{
    _touchPoint = touchPoint;
    
    [self invalidateLayout];
}

#pragma mark - Properties

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
