//
//  IndexPerformanceViewController.m
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "IndexPerformanceViewController.h"
#import "IndexReturnChartView.h"
#import "IndexPerformanceChartView.h"

@interface IndexPerformanceViewController ()
@property (nonatomic, strong) IndexPerformanceChartView *performanceChart;
@end

@implementation IndexPerformanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"IndexReturnChartView"
                                                         owner:self
                                                       options:nil];
    
    IndexReturnChartView *chartView = [nibContents objectAtIndex:0];
    chartView.frame = CGRectMake(0, 0, 320, 250); //or whatever coordinates you need
    self.view = chartView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
