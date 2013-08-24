//
//  IndexReturnChartView.m
//  Matrix
//
//  Created by Alondo  on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "IndexReturnChartView.h"
#import "IndexPerformanceChartView.h"

@interface IndexReturnChartView ()

@property (nonatomic, strong) IBOutlet UILabel *startYearLabel;
@property (nonatomic, strong) IBOutlet UILabel *endYearLabel;
@property (nonatomic, strong) IBOutlet UILabel *indexTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *indexSubtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *growthLabel;

@property (nonatomic, strong) IBOutlet IndexPerformanceChartView *chartBGView;

@property (nonatomic, strong) IBOutlet UILabel *level0Label;
@property (nonatomic, strong) IBOutlet UILabel *level1Label;
@property (nonatomic, strong) IBOutlet UILabel *level2Label;
@property (nonatomic, strong) IBOutlet UILabel *level3Label;
@property (nonatomic, strong) IBOutlet UILabel *level4Label;
@property (nonatomic, strong) IBOutlet UILabel *level5Label;
@property (nonatomic, strong) IBOutlet UILabel *level6Label;

@end

@implementation IndexReturnChartView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    _chartBGView = [[IndexPerformanceChartView alloc] initWithFrame:_chartBGView.frame];
}

@end
