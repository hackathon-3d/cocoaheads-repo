//
//  IndexPerformanceViewController.m
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockPerformanceViewController.h"
#import "StockIndexView.h"
#import "StockPerformanceChartView.h"
#import "StockIndex+SampleData.h"

@interface StockPerformanceViewController ()
@property (nonatomic, strong) IBOutlet StockIndexView *performanceChart;
@end

@implementation StockPerformanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _performanceChart = [[StockIndexView alloc] initForStockIndex:[[StockIndex sampleData] lastObject]
                                                            frame:CGRectMake(0, 0, 320, 250)];
    [_performanceChart setStockIndex:[[StockIndex sampleData] lastObject]];
    
    [self.view addSubview:self.performanceChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
