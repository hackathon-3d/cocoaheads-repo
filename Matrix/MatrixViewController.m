//
//  MatrixViewController.m
//  Matrix
//
//  Created by Ryan Poolos on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "MatrixViewController.h"

@interface MatrixViewController () <UIScrollViewDelegate>
{
    NSMutableArray *visibleCells;
    NSMutableArray *dequeueCells;
}

@property (nonatomic, readwrite) NSInteger startingYear;
@property (nonatomic, readwrite) NSInteger endingYear;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UIScrollView *verticalYearScrollView;
@property (nonatomic, strong) UIScrollView *horizontalYearScrollView;

@property (nonatomic, strong) UIScrollView *gridScrollView;
@property (nonatomic, strong) UIView *gridContainerView;

@end

#define Padding (4.0)

#define Header (44.0)

#define VerticalGutter (44.0)
#define HorizontalGutter (24.0)

#define ZoomMinimum (0.25)

#define DEBUG_FRAMES (1)

@implementation MatrixViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.startingYear = 1950;
        self.endingYear = 2000;
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

- (UILabel *)createGridViewCell
{
    CGFloat zoomMultiplier = 1.0 / ZoomMinimum;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds) * zoomMultiplier;
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds) * zoomMultiplier;

    
    // Create Cell
    UILabel *cell = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, height)];
    
    [cell setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
    
    [cell setTextAlignment:NSTextAlignmentCenter];
    [cell setTextColor:[UIColor whiteColor]];
    
    [cell setFont:[UIFont boldSystemFontOfSize:14.0 * zoomMultiplier]];
    
    [cell setText:[NSString stringWithFormat:@"%.02f",(arc4random_uniform(100) / 100.0)]];
    
    [self.gridContainerView addSubview:cell];
    
    
    
    return cell;
}

- (void)recycleGridCell:(UILabel *)cell
{
    [dequeueCells addObject:cell];
    [visibleCells removeObject:cell];
    
    [cell setHidden:YES];

}

- (UILabel *)dequeueGridViewCell
{
    UILabel *cell = dequeueCells.lastObject;
    
    if (!cell) {
        cell = [self createGridViewCell];
    }
    
    [visibleCells addObject:cell];
    [cell setHidden:NO];
    
    return cell;
}

- (void)loadGridCellForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat zoomMultiplier = 1.0 / ZoomMinimum;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds) * zoomMultiplier;
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds) * zoomMultiplier;
    
    
    
    UILabel *label = [self dequeueGridViewCell];
    NSLog(@"loadGridCellForIndexPath: %@",label);
    
    [label setFrame:CGRectMake(((width + Padding) * indexPath.section), ((height + Padding) * indexPath.item), width, height)];
}

- (void)updateGridCells
{
    CGFloat zoomMultiplier = 1.0 / ZoomMinimum;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds) * zoomMultiplier;
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds) * zoomMultiplier;

    
    CGRect visibleRect = (CGRect){self.gridScrollView.contentOffset, self.gridScrollView.bounds.size};
    visibleRect.origin.x -= width;
    visibleRect.origin.y -= height;
    visibleRect.size.width += (width * 2.0);
    visibleRect.size.height += (height * 2.0);
    
    // Recycle off screen cells
    for (UILabel *label in visibleCells.copy) {
        if (!CGRectContainsRect(visibleRect, label.frame)) {
            [self recycleGridCell:label];
        }
    }
    
    // Calculator visible cells and load
    int firstSection = CGRectGetMinX(visibleRect) / width;
    int firstItem = CGRectGetMinY(visibleRect) / height;
    int sections = CGRectGetWidth(visibleRect) / width;
    int items = CGRectGetHeight(visibleRect) / height;
    
    for (int x = firstSection; x < (firstSection + sections); x++) {
        for (int y = firstItem; y < (firstItem + items); y++) {
            if (x >= 0 && y >= 0) {
                [self loadGridCellForIndexPath:[NSIndexPath indexPathForItem:y inSection:x]];
            }
        }
    }
    
    
}

- (void)setupData
{
    visibleCells = [NSMutableArray array];
    dequeueCells = [NSMutableArray array];
    
    NSInteger difference = self.endingYear - self.startingYear;
    
    CGFloat zoomMultiplier = 1.0 / ZoomMinimum;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds) * zoomMultiplier;
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds) * zoomMultiplier;
    
    [self.gridScrollView setContentSize:CGSizeMake((width + Padding) * difference, (height + Padding) * difference)];
    [self.gridContainerView setFrame:CGRectMake(0.0, 0.0, self.gridScrollView.contentSize.width, self.gridScrollView.contentSize.height)];
    
//    // Top to Bottom
//    for (int x = 0; x < difference; x++) {
//        for (int y = 0; y < difference; y++) {
//            if (x <= y) {
//                UILabel *label = [self createGridViewCell];
//                
//                [label setFrame:CGRectMake(((width + Padding) * x), ((height + Padding) * y), width, height)];
//                
//                [visibleCells addObject:label];
//            }
//        }
//    }
    
    [self updateGridCells];

}

#pragma mark - Years

- (void)setupYears
{
    NSInteger difference = self.endingYear - self.startingYear;
    
    CGFloat height = CGRectGetHeight(self.horizontalYearScrollView.bounds);
    CGFloat width = CGRectGetWidth(self.verticalYearScrollView.bounds);
    
    for (int i = 0; i < difference; i++) {
        int year = self.startingYear + i;
        
        UILabel *verticalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, ((height + Padding) * i), width, height)];
        
        [verticalLabel setText:[NSString stringWithFormat:@"%i",year]];
        
        [verticalLabel setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [verticalLabel setTextColor:[UIColor whiteColor]];
        [verticalLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self.verticalYearScrollView addSubview:verticalLabel];
        
        [self.verticalYearScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.verticalYearScrollView.bounds), CGRectGetMaxY(verticalLabel.frame))];
        
        //
        UILabel *horizontalLabel = [[UILabel alloc] initWithFrame:CGRectMake(((width + Padding) * i), 0.0, width, height)];
        
        [horizontalLabel setText:[NSString stringWithFormat:@"%i",year]];
        
        [horizontalLabel setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == self.gridScrollView) {
        return self.gridContainerView;
    }
    
    return nil;
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
        
        [_gridScrollView setZoomScale:ZoomMinimum];
        [_gridScrollView setMinimumZoomScale:ZoomMinimum];
        [_gridScrollView setMaximumZoomScale:1.0];
        
        [_gridScrollView.panGestureRecognizer setMinimumNumberOfTouches:2];
        
        [_gridScrollView setBackgroundColor:(DEBUG_FRAMES ? [[UIColor blackColor] colorWithAlphaComponent:0.25] : [UIColor clearColor])];
        
        [self.view addSubview:_gridScrollView];
    }
    
    return _gridScrollView;
}

- (UIView *)gridContainerView
{
    if (!_gridContainerView) {
        _gridContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.gridScrollView.contentSize.width, self.gridScrollView.contentSize.height)];
        
        [self.gridScrollView addSubview:_gridContainerView];
    }
    
    return _gridContainerView;
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
