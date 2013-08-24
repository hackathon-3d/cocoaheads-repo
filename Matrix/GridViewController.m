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
    
    self.gridView = [[GridView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.gridView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    //[self.gridView addSubview:imageView];
    [self.view addSubview:self.gridView];
    
    
}

/*
// make image
-(UIImage*) makeImage {
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}
*/

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

// zoom in
- (void)zoomInToSectionContainingPoint:(CGPoint)point
{
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
    
    // take snapshot
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
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPoint newCenter = CGPointMake(512.0, 374.0);
    myView.alpha = 1;
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
        myView.transform = tr;
        myView.center = _oldGridViewCenter;
    } completion:^(BOOL finished) {
        myView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        myView.center = newCenter;        
    }];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
