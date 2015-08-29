//
//  oilFoot.m
//  送哪儿
//
//  Created by 南江 on 15/8/17.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "oilFoot.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import"MBProgressHUD+MJ.h"

@interface oilFoot ()
@property (weak, nonatomic) IBOutlet UIView *imgtable;
@property (weak, nonatomic) IBOutlet UILabel *totalkm;
@property (weak, nonatomic) IBOutlet UILabel *monthkm;
@property (weak, nonatomic) IBOutlet UILabel *monthmoney;
@property (weak, nonatomic) IBOutlet UILabel *totkm;
@property (weak, nonatomic) IBOutlet UILabel *totmoney;
@property(strong,nonatomic)NSArray *tgs;
@property(strong,nonatomic)NSString *monthnum1;
@property(strong,nonatomic)NSString *mi1;
@property(strong,nonatomic)NSString *monthnum2;
@property(strong,nonatomic)NSString *mi2;
@property(strong,nonatomic)NSString *monthnum3;
@property(strong,nonatomic)NSString *mi3;
@property(strong,nonatomic)NSString *monthnum4;
@property(strong,nonatomic)NSString *mi4;
@property (weak, nonatomic) IBOutlet UIButton *oilcardnum;

@property (weak, nonatomic) IBOutlet UIButton *yuer;
@property (nonatomic, strong) NSTimer *_updateTimer95;
@property (weak, nonatomic) IBOutlet UILabel *mibel;
@property (weak, nonatomic) IBOutlet UILabel *top;



@end

@implementation oilFoot

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
      [self network];

    
 
    
}

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
    
   
    
}

- (void)df
{
    
    //initate the graph view
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0,320,200)];
    
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.8],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:13],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @10,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4],
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortArray = [[NSArray alloc] initWithObjects:_mi1,_mi2,_mi3,_mi4,nil];
    
    NSArray *array = [sortArray sortedArrayUsingComparator:cmptr];
    NSString *max = [array lastObject];
    
  
    
    int intString =ceilf([max intValue]+3000);
 
    self.top.text=[NSString stringWithFormat:@"%d",intString];
     self.mibel.text=[NSString stringWithFormat:@"%d",intString/2];
    
    _lineGraph.yAxisRange = @(intString);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    
    
    NSLog(@"%@",_monthnum1);
    if (_monthnum2==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+1];
    
    }
    if (_monthnum3==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+2];
        
    }
    if (_monthnum4==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+3];
        
    }
    
    _lineGraph.xAxisValues = @[
                               @{ @1 : @6},
                               @{ @2 : @6},
                               @{ @3 : @6},
                               @{ @4 :@6},
                               ];
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    _plot1.plottingValues = @[
                              @{ @1 :@6},
                              @{ @2 :@6 },
                              @{ @3 :@6  },
                              @{ @4 :@6},
                              ];
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"1", @"2", @"3", @"4"];
    

    _plot1.plottingPointsLabels= arr;
    
    
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.85 green:0.94 blue:0.99 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.06 green:0.47 blue:0.87 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.06 green:0.47 blue:0.87 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.imgtable addSubview:_lineGraph];

}

- (void)df2
{
    
    //initate the graph view
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0,320,200)];
    
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.8],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:13],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @10,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4],
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *sortArray = [[NSArray alloc] initWithObjects:_mi1,_mi2,_mi3,_mi4,nil];
    
    NSArray *array = [sortArray sortedArrayUsingComparator:cmptr];
    NSString *max = [array lastObject];
    
    
    
    int intString =ceilf([max intValue]+3000);
    
    self.top.text=[NSString stringWithFormat:@"%d",intString];
    self.mibel.text=[NSString stringWithFormat:@"%d",intString/2];
    
    _lineGraph.yAxisRange = @(intString);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    
    
    NSLog(@"%@",_monthnum1);
    if (_monthnum2==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+1];
        
    }
    if (_monthnum3==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+2];
        
    }
    if (_monthnum4==0) {
        _monthnum2=[NSString stringWithFormat:@"%d",[_monthnum1 intValue]+3];
        
    }
    
    _lineGraph.xAxisValues = @[
                               @{ @1 :@6 },
                               @{ @2 :@6},
                               @{ @3 :@6},
                               @{ @4 :@6},
                               ];
    
    //create a new plot object that you want to draw on the `_lineGraph`
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    _plot1.plottingValues = @[
                              @{ @1 :@6},
                              @{ @2 :@6 },
                              @{ @3 :@6 },
                              @{ @4 :@6},
                              ];
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"1", @"2", @"3", @"4"];
    
    
    _plot1.plottingPointsLabels= arr;
    
    
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.85 green:0.94 blue:0.99 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.06 green:0.47 blue:0.87 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.06 green:0.47 blue:0.87 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:15]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self.imgtable addSubview:_lineGraph];
    
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

-(void)network3{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSString *myString = [userDefaultes stringForKey:@"myidt"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/API/HDL_SNROilCard.ashx?action=subsidyviewday&q0=%@",urlt,myString];
    NSLog(@"%@",urlStr);
    NSString *str = @"type=focus-c";
    
    AFHTTPRequestOperation *op=[self POSTurlString:urlStr parameters:str];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict=responseObject;
        if (![dict[@"ResultObject"] isEqual:[NSNull null]]) {
            NSDictionary *dict1=dict[@"ResultObject"];
        self.totalkm.text=[NSString stringWithFormat:@"%@",dict1[@"SMonty"]];
              [self.view setNeedsDisplay];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD showError:@"网络请求出错"];
        
        return ;
        
    }];
    
    
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
    
    
}





-(void)network{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    NSString *myString = [userDefaultes stringForKey:@"myidt"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/API/YWT_Order.ashx?action=monthview&q0=%@",urlt,myString];
    NSLog(@"----%@",urlStr);
    NSString *str = @"type=focus-c";

    AFHTTPRequestOperation *op=[self POSTurlString:urlStr parameters:str];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict=responseObject;
        NSLog(@"------%@",dict);
        if (![dict[@"ResultObject"] isEqual:[NSNull null]]) {
            NSDictionary *dict1=dict[@"ResultObject"];
            

            
            //当月
            if (![dict1[@"CMSubsidy"] isEqual:[NSNull null]]) {
                NSDictionary *dict3=dict1[@"CMSubsidy"];
                self.monthkm.text=[NSString stringWithFormat:@"%@",dict3[@"Mileage"]];
                self.monthmoney.text=[NSString stringWithFormat:@"%@",dict3[@"SubsidyMoney"]];
            }
            
            
            //总计
            if (![dict1[@"SumSubsidy"] isEqual:[NSNull null]]) {
                NSDictionary *dict4=dict1[@"SumSubsidy"];
                self.totkm.text=[NSString stringWithFormat:@"%@",dict4[@"SumMileage"]];
                self.totmoney.text=[NSString stringWithFormat:@"%@",dict4[@"SumSubsidyMoney"]];
            }
            
            //油卡数量余额
            if (![dict1[@"CardInfo"] isEqual:[NSNull null]]) {
                NSDictionary *dict4=dict1[@"CardInfo"];
                NSString *carnum=[NSString stringWithFormat:@"油卡数量 %@",dict4[@"CardNum"]];
                NSString *yuer=[NSString stringWithFormat:@"余额 %@",dict4[@"TopSum"]];
                [self.oilcardnum setTitle:carnum forState:UIControlStateNormal];
                 [self.yuer setTitle:yuer forState:UIControlStateNormal];
                
            }
            
            
            if (![dict1[@"M4Subsidys"] isEqual:[NSNull null]]) {
                NSArray *month=[dict1 objectForKey:@"M4Subsidys"];
                
                if (month.count>0) {
                    
                    NSDictionary *dict1=[month objectAtIndex:0];
                    _monthnum1=[NSString stringWithFormat:@"%@月份",dict1[@"IMonth"]];
                    _mi1=[NSString stringWithFormat:@"%@",dict1[@"Mileage"]];
                }else{
                    _monthnum1=@"0";
                    _mi1=@"0";
                }
                if (month.count>1) {
                    NSDictionary *dict2=[month objectAtIndex:1];
                    _monthnum2=[NSString stringWithFormat:@"%@月份",dict2[@"IMonth"]];
                    _mi2=[NSString stringWithFormat:@"%@",dict2[@"Mileage"]];
                }else{
                    _monthnum2=@"0";
                    _mi2=@"0";
                }
                if (month.count>2) {
                    NSDictionary *dict3=[month objectAtIndex:2];
                    _monthnum3=[NSString stringWithFormat:@"%@月份",dict3[@"IMonth"]];
                    _mi3=[NSString stringWithFormat:@"%@",dict3[@"Mileage"]];
                }else{
                    _monthnum3=@"0";
                    _mi3=@"0";
                }
                if (month.count>3) {
                    NSDictionary *dict4=[month objectAtIndex:3];
                    _monthnum4=[NSString stringWithFormat:@"%@月份",dict4[@"IMonth"]];
                    _mi4=[NSString stringWithFormat:@"%@",dict4[@"Mileage"]];
                }else{
                    _monthnum4=@"0";
                    _mi4=@"0";
                }
                [self df];
                

        }
        
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD showError:@"网络请求出错"];
        
        return ;
        
    }];
    
    
    
    [[NSOperationQueue mainQueue] addOperation:op];
    
    
    
}
-(NSArray *)arrys:(NSArray *)array{
    _tgs=array;
    return _tgs;
}


@end
