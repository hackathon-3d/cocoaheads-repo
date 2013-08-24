//
//  GridView.m
//  Matrix
//
//  Created by GLYN THOMAS on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "GridView.h"

#define SECTION_COL_TOTAL 3
#define SECTION_ROW_TOTAL 3

@implementation GridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // create chart grid
        [self createChartGrid];
    }
    return self;
}

-(void)createChartGrid
{
    for (int j = 0; j < SECTION_ROW_TOTAL; j++) {
        for (int i = 0; i < SECTION_COL_TOTAL; i++) {
            //ChartView *chart = [[ChartView aloc] init];
        
        }
    }
}

-(int)getSectionIndexFromPoint:(CGPoint)point
{
    int sectionWidth = (int)self.frame.size.width/SECTION_COL_TOTAL;
    int sectionHeight = (int)self.frame.size.height/SECTION_ROW_TOTAL;
    
    int col = (int)point.x/sectionWidth;
    int row = (int)point.y/sectionHeight;
    
    int sectionIndex = row*SECTION_ROW_TOTAL+col;
    
    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: point x:%f, y:%f", point.x, point.y]);

    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: %d row:%d, col:%d", sectionIndex, row, col]);
    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: section w:%d, h:%d", sectionWidth, sectionHeight]);
    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: frame w:%f, h:%f", self.frame.size.width, self.frame.size.height]);
    return sectionIndex;
}


-(CGPoint)getSectionUnitCenter:(int)sectionIndex
{
    int col = sectionIndex%SECTION_COL_TOTAL;
    int row = (int)sectionIndex/SECTION_ROW_TOTAL;
    
    float sectionUnitCenterX = (0.5+col)/SECTION_COL_TOTAL;
    float sectionUnitCenterY = (0.5+row)/SECTION_ROW_TOTAL;
    CGPoint point = CGPointMake(sectionUnitCenterX, sectionUnitCenterY);
    return point;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
