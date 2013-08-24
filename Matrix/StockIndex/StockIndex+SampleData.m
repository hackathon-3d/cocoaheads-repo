//
//  StockIndex+SampleData.m
//  Matrix
//
//  Created by Alondo  on 8/24/13.
//  Copyright (c) 2013 Cocoaheads. All rights reserved.
//

#import "StockIndex+SampleData.h"

@implementation StockIndex (SampleData)

+ (NSArray *)sampleData {
    
    NSArray *returnRates = @[[self sp500], [self famaFrench],
                             [self dimensionalUS], [self dimensionalIntl], [self dimensionalLargeCap],
                             [self dimensionalSmallCap], [self msci], [self dowJonesREIT], [self dowJonesUBS]];
    return returnRates;
}

+ (StockIndex *)sp500 {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"S & P 500 Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000, kStockIndexReturnRateKey:@1.7},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@2.6},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@4.0},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@7.1},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@4.9},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@4.2},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@4.1},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@2.3},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@1.7},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@14.6},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@10.9},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@8.8},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@16.0},
     ]];
    return stockIndex1;
}

+ (StockIndex *)famaFrench {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"FAMA/French Total US Market Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@2.2},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@3.4},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@4.8},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@7.9},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@5.5},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@4.7},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@4.5},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@2.8},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@2.3},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@15.3},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@11.0},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@7.8},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@15.1},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dimensionalUS {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dimensional US Adjusted Market Value Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@7.9},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@7.7},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@7.6},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@10.4},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@6.7},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@5.2},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@4.8},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@2.6},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@3.7},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@18.4},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@12.4},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@6.4},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@19.3},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dimensionalLargeCap {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dimensional US Large Cap Growth Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@2.1},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@3.2},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@4.8},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@7.8},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@6.4},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@6.1},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@6.7},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@6.0},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@5.1},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@16.3},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@13.1},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@10.7},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@15.3},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dimensionalSmallCap {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dimensional US Small Cap Growth Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@7.6},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@8.0},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@7.9},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@10.3},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@7.5},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@5.9},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@5.8},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@4.3},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@4.8},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@18.9},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@15.0},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@8.5},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@15.6},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dowJonesREIT {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dow Jones US Select REIT Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@12.3},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@10.9},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@10.7},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@11.5},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@9.0},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@6.3},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@5.3},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@0.9},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@5.1},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@20.5},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@17.9},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@13.2},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@17.1},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dowJonesUBS {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dow Jones-UBS Commodity Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@5.5},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@3.5},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@5.9},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@4.1},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@2.1},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@1.2},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@-1.3},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@-1.9},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@-5.2},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@4.5},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@0.1},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@-7.4},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@-1.1},
     ]];
    return stockIndex1;
}

+ (StockIndex *)dimensionalIntl{
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"Dimensional International Large Cap Growth Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@3.0},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@5.3},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@8.0},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@9.9},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@7.2},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@5.7},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@4.1},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@1.3},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@-1.2},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@12.0},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@6.0},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@3.3},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@17.9},
     ]];
    return stockIndex1;
}

+ (StockIndex *)msci {
    StockIndex *stockIndex1 = [[StockIndex alloc] init];
    [stockIndex1 setTitle:@"MSCI EAFE Index"];
    [stockIndex1 setStartYear:2000];
    [stockIndex1 setEndYear:2012];
    [stockIndex1 setAnnualReturns:@[@{kStockIndexYearKey:@2000,kStockIndexReturnRateKey:@1.7},
     @{kStockIndexYearKey:@2001,kStockIndexReturnRateKey:@3.2},
     @{kStockIndexYearKey:@2002,kStockIndexReturnRateKey:@5.8},
     @{kStockIndexYearKey:@2003,kStockIndexReturnRateKey:@8.2},
     @{kStockIndexYearKey:@2004,kStockIndexReturnRateKey:@5.3},
     @{kStockIndexYearKey:@2005,kStockIndexReturnRateKey:@3.5},
     @{kStockIndexYearKey:@2006,kStockIndexReturnRateKey:@2.2},
     @{kStockIndexYearKey:@2007,kStockIndexReturnRateKey:@-1.4},
     @{kStockIndexYearKey:@2008,kStockIndexReturnRateKey:@-3.7},
     @{kStockIndexYearKey:@2009,kStockIndexReturnRateKey:@10.0},
     @{kStockIndexYearKey:@2010,kStockIndexReturnRateKey:@3.6},
     @{kStockIndexYearKey:@2011,kStockIndexReturnRateKey:@1.5},
     @{kStockIndexYearKey:@2012,kStockIndexReturnRateKey:@17.3},
     ]];
    return stockIndex1;
}




@end
