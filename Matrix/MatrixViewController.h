//
//  MatrixViewController.h
//  Matrix
//
//  Created by Ryan Poolos on 8/23/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockIndex.h"
#import "StockIndex+SampleData.h"

@interface MatrixViewController : UIViewController

@property (nonatomic, strong) StockIndex *stockIndex;

@end
