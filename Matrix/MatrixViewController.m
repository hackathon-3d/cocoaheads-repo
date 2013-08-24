//
//  MatrixViewController.m
//  Matrix
//
//  Created by Ryan Poolos on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "MatrixViewController.h"

@interface MatrixViewController () <UIScrollViewDelegate>

@property (nonatomic, readwrite) NSInteger startingYear;
@property (nonatomic, readwrite) NSInteger endingYear;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIScrollView *verticalYearScrollView;
@property (nonatomic, strong) UIScrollView *horizontalYearScrollView;

@property (nonatomic, strong) UIScrollView *gridScrollView;

@end

#define Padding (2.0)

#define Header (44.0)

#define VerticalGutter (44.0)
#define HorizontalGutter (24.0)

#define DEBUG_FRAMES (1)

@implementation MatrixViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.startingYear = 1926;
        self.endingYear = 2013;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    [self backButton];
    
    [self.titleLabel setText:@"S&P Global Index"];
    
    [self setupYears];
    [self setupData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(id)sender
{
    
}

#pragma mark - Data

- (void)setupData
{
    NSInteger difference = self.endingYear - self.startingYear;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds);
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds);
    
    // Top to Bottom
    for (int x = 0; x < difference; x++) {
        for (int y = 0; y < difference; y++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((width * x), (height * y), width, height)];
            
            [label setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
            
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor whiteColor]];
            
            [label setFont:[UIFont boldSystemFontOfSize:14.0]];
            
            [label setText:[NSString stringWithFormat:@"%.02f",(arc4random_uniform(100) / 100.0)]];
            
            [self.gridScrollView addSubview:label];
            
            [self.gridScrollView setContentSize:CGSizeMake(CGRectGetMaxX(label.frame), CGRectGetMaxY(label.frame))];
        }
    }

}

#pragma mark - Years

- (void)setupYears
{
    NSInteger difference = self.endingYear - self.startingYear;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds);
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds);
    
    for (int i = 0; i < difference; i++) {
        int year = self.startingYear + i;
        
        UILabel *verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, (height * i), width, height)];
        
        [verticalLabel setText:[NSString stringWithFormat:@"%i",year]];
        
        [verticalLabel setBackgroundColor:[UIColor clearColor]];
        
        [verticalLabel setTextColor:[UIColor whiteColor]];
        [verticalLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.verticalYearScrollView addSubview:verticalLabel];
        
        [self.verticalYearScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.verticalYearScrollView.bounds), CGRectGetMaxY(verticalLabel.frame))];
        
        //
        UILabel *horizontalLabel = [[UILabel alloc] initWithFrame:CGRectMake((width * i), 0.0, width, height)];
        
        [horizontalLabel setText:[NSString stringWithFormat:@"%i",year]];
        
        [horizontalLabel setBackgroundColor:[UIColor clearColor]];
        
        [horizontalLabel setTextColor:[UIColor whiteColor]];
        [horizontalLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.horizontalYearScrollView addSubview:horizontalLabel];
        
        [self.horizontalYearScrollView setContentSize:CGSizeMake(CGRectGetMaxX(horizontalLabel.frame), CGRectGetHeight(self.horizontalYearScrollView.bounds))];
        
        
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.gridScrollView) {
        [self.verticalYearScrollView setContentOffset:CGPointMake(0.0, scrollView.contentOffset.y)];
        [self.horizontalYearScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0.0)];
        
    }
    else if (scrollView == self.verticalYearScrollView) {
        [self.gridScrollView setContentOffset:CGPointMake(self.gridScrollView.contentOffset.x, self.verticalYearScrollView.contentOffset.y)];
        
    }
    else if (scrollView == self.horizontalYearScrollView) {
        [self.gridScrollView setContentOffset:CGPointMake(self.horizontalYearScrollView.contentOffset.x, self.gridScrollView.contentOffset.y)];
    }
}

#pragma mark - Views

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
        
        [_titleLabel setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [_backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_backButton];
    }
    
    return _backButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 44.0)];
        [_titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
        
        [_titleLabel setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [_titleLabel setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
        
        [_titleLabel setText:@"Index Title"];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
        
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIScrollView *)gridScrollView
{
    if (!_gridScrollView) {
        _gridScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(VerticalGutter + Padding, Header + Padding, CGRectGetWidth(self.view.bounds) - (VerticalGutter * 2.0) - (Padding * 2.0), CGRectGetHeight(self.view.bounds) - Header - HorizontalGutter - (Padding * 2.0))];
        [_gridScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
        [_gridScrollView setDelegate:self];
        
        [_gridScrollView setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [self.view addSubview:_gridScrollView];
    }
    
    return _gridScrollView;
}

- (UIScrollView *)verticalYearScrollView
{
    if (!_verticalYearScrollView) {
        _verticalYearScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, Header + Padding, VerticalGutter, CGRectGetHeight(self.view.bounds) - Header - HorizontalGutter - (Padding * 2.0))];
        [_verticalYearScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
        
        [_verticalYearScrollView setDelegate:self];
        
        [_verticalYearScrollView setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [self.view addSubview:_verticalYearScrollView];
    }
    
    return _verticalYearScrollView;
}


- (UIScrollView *)horizontalYearScrollView
{
    if (!_horizontalYearScrollView) {
        _horizontalYearScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(VerticalGutter + Padding, CGRectGetHeight(self.view.bounds) - HorizontalGutter, CGRectGetWidth(self.view.bounds) - (VerticalGutter * 2.0) - (Padding * 2.0), HorizontalGutter)];
        [_horizontalYearScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
        
        [_horizontalYearScrollView setDelegate:self];
        
        [_horizontalYearScrollView setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [self.view addSubview:_horizontalYearScrollView];
    }
    
    return _horizontalYearScrollView;
}

@end
