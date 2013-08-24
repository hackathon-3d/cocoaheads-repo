//
//  GridViewController.m
//  Matrix
//
//  Created by Ryan Poolos on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "GridViewController.h"
#import "MatrixViewController.h"
#import <QuartzCore/QuartzCore.h>

#define SECTION_COL_TOTAL 3
#define SECTION_ROW_TOTAL 3

@interface GridViewController ()
@property (strong,nonatomic) UIView *gridView;
@property (nonatomic) int selectedQuadrant;
@end


@implementation GridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleTap:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    
    UIImage *image = [UIImage imageNamed:@"gridViewTemp04.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    //NSLog( [NSString stringWithFormat:@"%f,%f", viewWidth, viewHeight]);
    
    self.gridView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.gridView addSubview:imageView];
    [self.view addSubview:self.gridView];
    
    
}
// tap gesture
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)     {
        // handling tap
        NSLog(@"Tap");
        CGPoint point = [sender locationInView:self.gridView];
        [self zoomInToSectionContainingPoint:point];
    }
}

- (void)zoomInToSectionContainingPoint:(CGPoint)point
{
    /*
    self.gridView.frame = CGRectMake(0, 0, 20, 20);
    CGPoint center = self.gridView.center;
    [UIView animateWithDuration: 1.0f animations:^{
        self.gridView.frame = CGRectMake(100, 100, 40, 40);
        self.gridView.center = center;
    }];
    */
    UIView *myView = self.gridView;
    CGAffineTransform tr = CGAffineTransformScale(myView.transform, 2, 2);
    //CGFloat h = myView.frame.size.height;
    
    //get section
    int sectionIndex = [self getSectionIndexFromPoint:point];
    CGPoint sectionUnitCenter = [self getSectionUnitCenter:sectionIndex];
    
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
        NSLog( [NSString stringWithFormat:@"ZoomInToPoint: [%f,%f]", sectionUnitCenter.x, sectionUnitCenter.y]);
        myView.layer.anchorPoint = sectionUnitCenter;
        // myView.center = CGPointMake(-sectionCenter.x, -sectionCenter.y);
        myView.transform = tr;
         
        
    } completion:^(BOOL finished) {
        [self presentViewController:[[MatrixViewController alloc] init] animated:NO completion:nil];
    }];
}

-(int)getSectionIndexFromPoint:(CGPoint)point
{
    int sectionWidth = (int)self.view.bounds.size.width/SECTION_COL_TOTAL;
    int sectionHeight = (int)self.view.bounds.size.height/SECTION_ROW_TOTAL;
    
    int col = (int)point.x/sectionWidth;
    int row = (int)point.y/sectionHeight;
    
    int sectionIndex = row*SECTION_ROW_TOTAL+col;
    
    NSLog( [NSString stringWithFormat:@"getSectionIndexFromPoint: %d", sectionIndex]);
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

- (void)zoomOutFromSelectedSection
{
    UIView *myView = self.gridView;
    CGAffineTransform tr = CGAffineTransformScale(myView.transform, .5, .5);
    //CGFloat h = myView.frame.size.height;
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
        myView.transform = tr;
        myView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    } completion:^(BOOL finished) {
        
    }];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
