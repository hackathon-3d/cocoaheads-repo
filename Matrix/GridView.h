//
//  GridView.h
//  Matrix
//
//  Created by GLYN THOMAS on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView
-(CGPoint)getSectionUnitCenter:(int)sectionIndex;
-(int)getSectionIndexFromPoint:(CGPoint)point;
@end
