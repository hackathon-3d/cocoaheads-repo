//
//  GridView.m
//  Matrix
//
//  Created by GLYN THOMAS on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "GridView.h"
#import "StockIndexView.h"
#import "StockIndex+SampleData.h"
#import "StockViewButton.h"

#define SECTION_COL_TOTAL 3
#define SECTION_ROW_TOTAL 3

@interface GridView() 
@property (nonatomic, strong) NSMutableArray *chartList;
@end

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
    
    int sectionWidth = (int)self.frame.size.width/SECTION_COL_TOTAL;
    int sectionHeight = (int)self.frame.size.height/SECTION_ROW_TOTAL;
    
                           
    self.chartList = [@[]mutableCopy];
    for (int j = 0; j < SECTION_ROW_TOTAL; j++) {
        for (int i = 0; i < SECTION_COL_TOTAL; i++) {
            //ChartView *chart = [[ChartView aloc] init];
            int index = j*SECTION_COL_TOTAL+i;
            StockIndexView *stockView = [[StockIndexView alloc] initForStockIndex:[[StockIndex sampleData] objectAtIndex:index]
                                                                            frame:CGRectMake(i*sectionWidth, j*sectionHeight, sectionWidth, sectionHeight)];
            [stockView setStockIndex:[[StockIndex sampleData] objectAtIndex:index]];
            self.chartList[index] = stockView;
            //[self addSubview: stockView];
        }
    }
}

- (void)layoutSubviews
{
    int sectionWidth = (int)self.frame.size.width/SECTION_COL_TOTAL;
    int sectionHeight = (int)self.frame.size.height/SECTION_ROW_TOTAL;
    
    
    NSArray *colorList = @[[UIColor redColor],
                           [UIColor greenColor],
                           [UIColor blackColor],
                           [UIColor blueColor],
                           [UIColor grayColor],
                           [UIColor yellowColor],
                           [UIColor purpleColor],
                           [UIColor redColor],
                           [UIColor greenColor]];
    
    
    
    for (int j = 0; j < SECTION_ROW_TOTAL; j++) {
        for (int i = 0; i < SECTION_COL_TOTAL; i++) {
            int index = j*SECTION_COL_TOTAL+i;
            UIView *stockView = self.chartList[index];
            stockView.frame = CGRectMake(0, 0, sectionWidth, sectionHeight);
            [stockView setUserInteractionEnabled:NO];
            
            UIButton *button = [[StockViewButton alloc]initWithFrame:CGRectMake(i*sectionWidth, j*sectionHeight, sectionWidth, sectionHeight)];
            [button addSubview:stockView];
            [button addTarget:self action:@selector(onSectionButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            stockView.backgroundColor = [UIColor clearColor];
            //stockView.alpha = .7;
            //button.backgroundColor = colorList[index];
        }
    }
}

-(void)onSectionButtonTapped:(id)sender
{
    
    CGPoint point = [(UIButton *)sender center];
    [self.delegate sectionButtonTapped:point];
}
-(int)getSectionIndexFromPoint:(CGPoint)point
{
    int sectionWidth = (int)self.frame.size.width/SECTION_COL_TOTAL;
    int sectionHeight = (int)self.frame.size.height/SECTION_ROW_TOTAL;
    
    int col = (int)point.x/sectionWidth;
    int row = (int)point.y/sectionHeight;
    
    int sectionIndex = row*SECTION_ROW_TOTAL+col;
    
//    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: point x:%f, y:%f", point.x, point.y]);
//
//    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: %d row:%d, col:%d", sectionIndex, row, col]);
//    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: section w:%d, h:%d", sectionWidth, sectionHeight]);
//    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: frame w:%f, h:%f", self.frame.size.width, self.frame.size.height]);
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
