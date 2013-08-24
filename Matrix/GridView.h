//
//  GridView.h
//  Matrix
//
//  Created by GLYN THOMAS on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionButtonTappedDelegate
-(void)sectionButtonTapped:(CGPoint)point;
@end

@interface GridView : UIView
-(CGPoint)getSectionUnitCenter:(int)sectionIndex;
-(int)getSectionIndexFromPoint:(CGPoint)point;
@property (weak, nonatomic) id  <SectionButtonTappedDelegate> delegate;
@end




