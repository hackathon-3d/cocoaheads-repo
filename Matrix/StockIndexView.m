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
    _indexSubtitleLabel.text = [NSString stringWithFormat:@"%d - %d: Total Returns", self.stockIndex.startYear, self.stockIndex.endYear];
    _startYearLabel.text = [NSString stringWithFormat:@"%d", self.stockIndex.startYear];
    _endYearLabel.text = [NSString stringWithFormat:@"%d", self.stockIndex.endYear];
    [self drawPerformanceChart];
}

- (void)initLayout {
    self.opaque = NO;
    [self drawChartLines];
    [self drawChartLabels];
}

- (void)drawPerformanceChart {
    _perfChartView = [[StockPerformanceChartView alloc] initForStockIndex:self.stockIndex frame:CGRectMake(70, 82, 240, 147)];
    [self addSubview:self.perfChartView];
}

- (void)drawChartLines{
    _level0LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 220, 240, 1)];
    [_level0LineView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:_level0LineView];
    _level1LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 199, 240, 1)];
    [self addSubview:_level1LineView];
    [_level1LineView setBackgroundColor:[UIColor blackColor]];
    _level2LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 178, 240, 1)];
    [self addSubview:_level2LineView];
    [_level2LineView setBackgroundColor:[UIColor blackColor]];
    _level3LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 157, 240, 1)];
    [self addSubview:_level3LineView];
    [_level3LineView setBackgroundColor:[UIColor blackColor]];
    _level4LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 136, 240, 1)];
    [self addSubview:_level4LineView];
    [_level4LineView setBackgroundColor:[UIColor blackColor]];
    _level5LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 115, 240, 1)];
    [self addSubview:_level5LineView];
    [_level5LineView setBackgroundColor:[UIColor blackColor]];
    _level6LineView = [[UIView alloc] initWithFrame:CGRectMake(70, 94, 240, 1)];
    [self addSubview:_level6LineView];
    [_level6LineView setBackgroundColor:[UIColor blackColor]];
}

- (void)drawChartLabels {
    UIFont *labelFont = [UIFont systemFontOfSize:11.0];
    _startYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 224, 42, 21)];
    [_startYearLabel setFont:labelFont];
    [_startYearLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_startYearLabel];
    
    _endYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(268, 224, 42, 21)];
    [_endYearLabel setTextAlignment:NSTextAlignmentRight];
    [_endYearLabel setFont:labelFont];
    [self addSubview:_endYearLabel];
    
    _indexTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 34)];
    [_indexTitleLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_indexTitleLabel];

    _indexSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 33, 279, 21)];
    [_indexSubtitleLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_indexSubtitleLabel];

    _growthLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 62, 100, 21)];
    [_growthLabel setTextAlignment:NSTextAlignmentRight];
    [_growthLabel setText:@"GROWTH OF $1"];
    [_growthLabel setFont:labelFont];
    [self addSubview:_growthLabel];
    
    _level0Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 209, 50, 21)];
    [_level0Label setText:@"$0"];
    [_level0Label setTextAlignment:NSTextAlignmentRight];
    [_level0Label setFont:labelFont];
    [self addSubview:_level0Label];
    
    _level1Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 188, 50, 21)];
    [_level1Label setText:@"$1"];
    [_level1Label setTextAlignment:NSTextAlignmentRight];
    [_level1Label setFont:labelFont];
    [self addSubview:_level1Label];
    
    _level2Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 167, 50, 21)];
    [_level2Label setText:@"$10"];
    [_level2Label setTextAlignment:NSTextAlignmentRight];
    [_level2Label setFont:labelFont];
    [self addSubview:_level2Label];
    
    _level3Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 146, 50, 21)];
    [_level3Label setText:@"$100"];
    [_level3Label setTextAlignment:NSTextAlignmentRight];
    [_level3Label setFont:labelFont];
    [self addSubview:_level3Label];
    
    _level4Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 125, 50, 21)];
    [_level4Label setText:@"$1,000"];
    [_level4Label setTextAlignment:NSTextAlignmentRight];
    [_level4Label setFont:labelFont];
    [self addSubview:_level4Label];
    
    _level5Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 104, 50, 21)];
    [_level5Label setText:@"$10,000"];
    [_level5Label setTextAlignment:NSTextAlignmentRight];
    [_level5Label setFont:labelFont];
    [self addSubview:_level5Label];
    
    _level6Label = [[UILabel alloc] initWithFrame:CGRectMake(5, 83, 50, 21)];
    [_level6Label setText:@"$100,000"];
    [_level6Label setTextAlignment:NSTextAlignmentRight];
    [_level6Label setFont:labelFont];
    [self addSubview:_level6Label];
}

@end
