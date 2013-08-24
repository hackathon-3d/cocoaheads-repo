//
//  GridViewController.m
//  Matrix
//
//  Created by Ryan Poolos on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "GridViewController.h"
#import "GridView.h"
#import "MatrixViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface GridViewController (){
    CGPoint _oldGridViewCenter;
    MatrixViewController *_matrixViewController;
    UIImage *_matrixViewControllerScreenShot;
}
@property (strong,nonatomic) GridView *gridView;
@property (nonatomic) int selectedQuadrant;

@end


@implementation GridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleTap:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.view addGestureRecognizer:tapRecognizer];
    
    float viewWidth = self.view.bounds.size.width;
    float viewHeight = self.view.bounds.size.height;
    
    [self setGradientBackground];
    
    self.gridView = [[GridView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.gridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:self.gridView];
}

- (void)setGradientBackground {
    CAGradientLayer *bgLayer = [self greenGradient];
    bgLayer.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    [self.view.layer insertSublayer:bgLayer atIndex:0];
}

- (CAGradientLayer*) greenGradient {
    
    UIColor *colorOne = [UIColor colorWithHue:77/359.0 saturation:0.56 brightness:0.73 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:52/359.0 saturation:0.94 brightness:0.87  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *bgLayer = [CAGradientLayer layer];
    bgLayer.colors = colors;
    bgLayer.locations = locations;
    bgLayer.startPoint = CGPointMake(0, 1);
    bgLayer.endPoint = CGPointMake(1, 0);
    
    return bgLayer;
    
}


// tap gesture
- (void)handleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded)     {
        // handling tap
        NSLog(@"Tap");
        CGPoint point = [sender locationInView:self.gridView];
        [self zoomInToSectionContainingPoint:point];
    }
}

// zoom in
- (void)zoomInToSectionContainingPoint:(CGPoint)point {
    UIView *myView = self.gridView;
    CGAffineTransform tr = CGAffineTransformScale(myView.transform, 3, 3);
    
    //get section
    int sectionIndex = [self.gridView getSectionIndexFromPoint:point];
    CGPoint sectionUnitCenter = [self.gridView getSectionUnitCenter:sectionIndex];
    
    myView.layer.anchorPoint = sectionUnitCenter;
    myView.center = CGPointMake(CGRectGetWidth(myView.frame) * myView.layer.anchorPoint.x, CGRectGetHeight(myView.frame) * myView.layer.anchorPoint.y);

    float viewHalfWidth = self.view.bounds.size.width*.5;
    float viewHalfHeight = self.view.bounds.size.height*.5;
    CGPoint finalGridViewCenter = CGPointMake(viewHalfWidth, viewHalfHeight);
    _oldGridViewCenter = myView.center;
    _matrixViewController = [[MatrixViewController alloc] init];
    
    // take snapshot _matrixViewController
    _matrixViewController.view.frame = self.view.bounds;
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [_matrixViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *matrixViewControllerSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *matrixViewControllerSnapshotImageView = [[UIImageView alloc] initWithImage:matrixViewControllerSnapshot];
    matrixViewControllerSnapshotImageView.alpha = 0;
    matrixViewControllerSnapshotImageView.center = myView.center;
    matrixViewControllerSnapshotImageView.transform = CGAffineTransformScale(matrixViewControllerSnapshotImageView.transform, .33, .33);
    [self.view addSubview: matrixViewControllerSnapshotImageView];
    
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
       
        myView.transform = tr;
        myView.center = finalGridViewCenter;
        myView.alpha = 0;
        matrixViewControllerSnapshotImageView.center = myView.center;
        matrixViewControllerSnapshotImageView.alpha = 1;
        matrixViewControllerSnapshotImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        myView.alpha = 0;
        matrixViewControllerSnapshotImageView.alpha = 0;
        [matrixViewControllerSnapshotImageView removeFromSuperview];
        [self presentViewController:_matrixViewController animated:NO completion:nil];

        
    }];
    
}

// zoom out
- (void)zoomOutFromSelectedSection
{
    UIView *myView = self.gridView;
    
    // take snapshot _matrixViewController
    _matrixViewController.view.frame = self.view.bounds;
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [_matrixViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *matrixViewControllerSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *matrixViewControllerSnapshotImageView = [[UIImageView alloc] initWithImage:matrixViewControllerSnapshot];
        [self.view addSubview: matrixViewControllerSnapshotImageView];
    
    
    
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPoint newCenter = CGPointMake(512.0, 374.0);
    myView.alpha = 1;
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
        myView.transform = tr;
        myView.center = _oldGridViewCenter;
        matrixViewControllerSnapshotImageView.alpha = 0;
        matrixViewControllerSnapshotImageView.center = myView.center;
        matrixViewControllerSnapshotImageView.transform = CGAffineTransformScale(matrixViewControllerSnapshotImageView.transform, .33, .33);

    } completion:^(BOOL finished) {
        myView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        myView.center = newCenter;
        [matrixViewControllerSnapshotImageView removeFromSuperview];
    }];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
