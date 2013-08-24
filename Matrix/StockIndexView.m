//
//  IndexReturnChartView.m
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockIndexView.h"
#import "StockPerformanceChartView.h"
#import "StockIndex+SampleData.h"

@interface StockIndexView ()

@property (nonatomic, strong) UILabel *startYearLabel;
@property (nonatomic, strong) UILabel *endYearLabel;
@property (nonatomic, strong) UILabel *indexTitleLabel;
@property (nonatomic, strong) UILabel *indexSubtitleLabel;
@property (nonatomic, strong) UILabel *growthLabel;

@property (nonatomic, strong) UILabel *level0Label;
@property (nonatomic, strong) UILabel *level1Label;
@property (nonatomic, strong) UILabel *level2Label;
@property (nonatomic, strong) UILabel *level3Label;
@property (nonatomic, strong) UILabel *level4Label;
@property (nonatomic, strong) UILabel *level5Label;
@property (nonatomic, strong) UILabel *level6Label;
@property (nonatomic, strong) UIView *level0LineView;
@property (nonatomic, strong) UIView *level1LineView;
@property (nonatomic, strong) UIView *level2LineView;
@property (nonatomic, strong) UIView *level3LineView;
@property (nonatomic, strong) UIView *level4LineView;
@property (nonatomic, strong) UIView *level5LineView;
@property (nonatomic, strong) UIView *level6LineView;

@property (nonatomic, strong) StockPerformanceChartView *perfChartView;

@end

@implementation StockIndexView

- (id)initForStockIndex:(StockIndex *)stockIndex frame:(CGRect)frame {
    if ((self = [self initWithFrame:frame])){
        _stockIndex = stockIndex;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
       [self initLayout];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)setStockIndex:(StockIndex *)stockIndex {
    _stockIndex = stockIndex;
    _indexTitleLabel.text = self.stockIndex.title;
    [_indexTitleLabel setBackgroundColor:[UIColor clearColor]];
    _indexSubtitleLabel.text = [NSString stringWithFormat:@"%d - %d: Total Returns", self.stockIndex.startYear, self.stockIndex.endYear];
    [_indexSubtitleLabel setBackgroundColor:[UIColor clearColor]];
    _startYearLabel.text = [NSString stringWithFormat:@"%d", self.stockIndex.startYear];
    [_startYearLabel setBackgroundColor:[UIColor clearColor]];
    _endYearLabel.text = [NSString stringWithFormat:@"%d", self.stockIndex.endYear];
    [_endYearLabel setBackgroundColor:[UIColor clearColor]];
    [self drawPerformanceChart];
}

- (void)initLayout {
    [self.layer setShouldRasterize:YES];
    [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
    UIColor *shadowColor = [UIColor blackColor];
    [self.layer setShadowColor:shadowColor.CGColor];
    [self.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.layer setShadowRadius:4.0];
    [self.layer setShadowOpacity:0.7];
    self.opaque = NO;
    [self setBackgroundColor:[UIColor clearColor]];
    [self drawChartLines];
    [self drawChartLabels];
}

- (void)drawPerformanceChart {
    _perfChartView = [[StockPerformanceChartView alloc] initForStockIndex:self.stockIndex frame:CGRectMake(70, 70, 240, 160)];
//    [_perfChartView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:self.perfChartView];
}

- (void)drawChartLines{
    UIColor *lineColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    _level0LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 220, 240, 1)];
    [_level0LineView setBackgroundColor:lineColor];
    [self addSubview:_level0LineView];
    _level1LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 199, 240, 1)];
    [self addSubview:_level1LineView];
    [_level1LineView setBackgroundColor:lineColor];
    _level2LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 178, 240, 1)];
    [self addSubview:_level2LineView];
    [_level2LineView setBackgroundColor:lineColor];
    _level3LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 157, 240, 1)];
    [self addSubview:_level3LineView];
    [_level3LineView setBackgroundColor:lineColor];
    _level4LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 136, 240, 1)];
    [self addSubview:_level4LineView];
    [_level4LineView setBackgroundColor:lineColor];
    _level5LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 115, 240, 1)];
    [self addSubview:_level5LineView];
    [_level5LineView setBackgroundColor:lineColor];
    _level6LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 94, 240, 1)];
    [self addSubview:_level6LineView];
    [_level6LineView setBackgroundColor:lineColor];
}

- (void)drawChartLabels {
    UIFont *labelFont = [UIFont systemFontOfSize:11.0];
    UIColor *labelColor = [UIColor whiteColor];
    _startYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 224, 42, 21)];
    [_startYearLabel setFont:labelFont];
    [_startYearLabel setTextColor:labelColor];
    [_startYearLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_startYearLabel];
    
    _endYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(268, 224, 42, 21)];
    [_endYearLabel setTextAlignment:NSTextAlignmentRight];
    [_endYearLabel setFont:labelFont];
    [_endYearLabel setTextColor:labelColor];
    [self addSubview:_endYearLabel];
    
    _indexTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 34)];
    [_indexTitleLabel setTextAlignment:NSTextAlignmentRight];
    [_indexTitleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [_indexTitleLabel setNumberOfLines:0];
    [_indexTitleLabel setTextColor:labelColor];
    [self addSubview:_indexTitleLabel];

    _indexSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 33, 279, 21)];
    [_indexSubtitleLabel setTextAlignment:NSTextAlignmentRight];
    [_indexSubtitleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [_indexSubtitleLabel setTextColor:labelColor];
    [self addSubview:_indexSubtitleLabel];

    _growthLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 62, 120, 21)];
    [_growthLabel setTextAlignment:NSTextAlignmentRight];
    [_growthLabel setText:@"GROWTH OF $100"];
    [_growthLabel setTextColor:labelColor];

    [_growthLabel setBackgroundColor:[UIColor clearColor]];
    [_growthLabel setFont:labelFont];
    [self addSubview:_growthLabel];
    
    _level0Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 209, 50, 21)];
    [_level0Label setText:@"$100"];
    [_level0Label setTextColor:labelColor];
    [_level0Label setTextAlignment:NSTextAlignmentRight];
    [_level0Label setBackgroundColor:[UIColor clearColor]];
    [_level0Label setFont:labelFont];
    [self addSubview:_level0Label];
    
    _level1Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 188, 50, 21)];
    [_level1Label setText:@"$125"];
    [_level1Label setTextColor:labelColor];
    [_level1Label setTextAlignment:NSTextAlignmentRight];
    [_level1Label setBackgroundColor:[UIColor clearColor]];
    [_level1Label setFont:labelFont];
    [self addSubview:_level1Label];
    
    _level2Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 167, 50, 21)];
    [_level2Label setText:@"$150"];
    [_level2Label setTextColor:labelColor];
    [_level2Label setTextAlignment:NSTextAlignmentRight];
    [_level2Label setBackgroundColor:[UIColor clearColor]];
    [_level2Label setFont:labelFont];
    [self addSubview:_level2Label];
    
    _level3Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 146, 50, 21)];
    [_level3Label setText:@"$175"];
    [_level3Label setTextColor:labelColor];
    [_level3Label setTextAlignment:NSTextAlignmentRight];
    [_level3Label setBackgroundColor:[UIColor clearColor]];
    [_level3Label setFont:labelFont];
    [self addSubview:_level3Label];
    
    _level4Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 125, 50, 21)];
    [_level4Label setText:@"$200"];
    [_level4Label setTextColor:labelColor];
    [_level4Label setTextAlignment:NSTextAlignmentRight];
    [_level4Label setBackgroundColor:[UIColor clearColor]];
    [_level4Label setFont:labelFont];
    [self addSubview:_level4Label];
    
    _level5Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 104, 50, 21)];
    [_level5Label setText:@"$225"];
    [_level5Label setTextColor:labelColor];
    [_level5Label setTextAlignment:NSTextAlignmentRight];
    [_level5Label setBackgroundColor:[UIColor clearColor]];
    [_level5Label setFont:labelFont];
    [self addSubview:_level5Label];
    
    _level6Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 83, 50, 21)];
    [_level6Label setText:@"$250"];
    [_level6Label setTextColor:labelColor];
    [_level6Label setTextAlignment:NSTextAlignmentRight];
    [_level6Label setBackgroundColor:[UIColor clearColor]];
    [_level6Label setFont:labelFont];
    [self addSubview:_level6Label];
}

@end
