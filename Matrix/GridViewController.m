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



@interface GridViewController ()
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
    CGAffineTransform tr = CGAffineTransformScale(myView.transform, 3, 3);
    //CGFloat h = myView.frame.size.height;
    
    //get section
    int sectionIndex = [self.gridView getSectionIndexFromPoint:point];
    CGPoint sectionUnitCenter = [self.gridView getSectionUnitCenter:sectionIndex];
//    CGPoint newCenter = CGPointMake((myView.layer.anchorPoint.x-sectionUnitCenter.x)*self.view.frame.size.width, (myView.layer.anchorPoint.y-sectionUnitCenter.y)*self.view.frame.size.height);
    
    myView.layer.anchorPoint = sectionUnitCenter;
    myView.center = CGPointMake(CGRectGetWidth(myView.frame) * myView.layer.anchorPoint.x, CGRectGetHeight(myView.frame) * myView.layer.anchorPoint.y);
    
    //CGPoint sectionUnitCenterOffset = CGPointMake((sectionUnitCenter.x-.5), (sectionUnitCenter.y-.5));
    
//    NSLog( [NSString stringWithFormat:@"zoomInToSectionContainingPoint: sectionUnitCenter x:%f y:%f",sectionUnitCenter.x,sectionUnitCenter.y]);
//    NSLog( [NSString stringWithFormat:@"zoomInToSectionContainingPoint: self.view.frame.size w:%f h:%f", self.view.frame.size.width,self.view.frame.size.height]);
//    NSLog( [NSString stringWithFormat:@"zoomInToSectionContainingPoint: newCenter x:%f y:%f",newCenter.x,newCenter.y]);
   // NSLog( [NSString stringWithFormat:@"zoomInToSectionContainingPoint: sectionUnitCenterOffset x:%f y:%f",sectionUnitCenterOffset.x,sectionUnitCenterOffset.y]);
    
//    NSLog( [NSString stringWithFormat:@"ZoomInToPoint: [%f,%f]", sectionUnitCenter.x, sectionUnitCenter.y]);
    //myView.layer.anchorPoint = sectionUnitCenter;
//    myView.center = newCenter;
    
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
       
        myView.transform = tr;
        
        
    } completion:^(BOOL finished) {
        [self presentViewController:[[MatrixViewController alloc] init] animated:NO completion:nil];
    }];
    
}


- (void)zoomOutFromSelectedSection
{
    UIView *myView = self.gridView;
    CGAffineTransform tr = CGAffineTransformScale(myView.transform, .33, .33);
    //CGFloat h = myView.frame.size.height;
    CGPoint newCenter = CGPointMake(512.0, 374.0);
     NSLog( [NSString stringWithFormat:@"zoomOutFromSectionContainingPoint: self.view.bounds.size w:%f h:%f", self.view.frame.size.width,self.view.frame.size.height]);
    [UIView animateWithDuration:1.0f delay:0 options:0 animations:^{
        myView.transform = tr;
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
