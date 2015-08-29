//
//  beginpiclist.m
//  test2
//
//  Created by 南江 on 15/8/27.
//  Copyright (c) 2015年 南江. All rights reserved.
//

#import "beginpiclist.h"
#import "beginpic.h"
#import "MJRefresh.h"

@interface beginpiclist ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *tgs;

@end

@implementation beginpiclist

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.rowHeight=130;
}

-(NSMutableArray *)netwok:(NSMutableArray *)array
{
    
    _tgs=array;
    return _tgs;
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict2=[_tgs objectAtIndex:indexPath.row];
    static NSString *ID = @"tg";
    beginpic *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"beginpic" owner:nil options:nil] lastObject];
    }

    
    return cell;
}



//#pragma mark  下拉加载
//
//-(NSMutableArray *)repeatnetwork{
//    
//    //   __block int pageNum=0;
//    //  __block  int  allPageNum=0;
//    // __block   int  noDispatchPageNum=0;
//    //  __block  int  transportPageNum=0;
//    // __block   int waitPayPageNum=0;
//    
//    self.tableview.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//    
//    //}];
//    return _tgs;
//    
//}
//-(void)loadMoreData
//{
//    int num=parameterNumber+1;
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *myString = [userDefaultes stringForKey:@"myidt"];
//    
//    NSString *urlStr2 = [NSString stringWithFormat:@"%@/API/HDL_SNROilCard.ashx?action=getlist&q0=%@&q1=%d",urlt,myString,num];
//    NSLog(@"---------%@",urlStr2);
//    
//    AFHTTPRequestOperation *op=[self GETurlString:urlStr2];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSMutableDictionary *dict=responseObject;
//        NSArray *dictarr=[dict objectForKey:@"ResultObject"];
//        if(![dictarr isEqual:[NSNull null]])
//        {
//            [_tgs addObjectsFromArray:dictarr];
//            [self.tableview reloadData];
//        }
//        [self.tableview.footer endRefreshing];
//        self.tableview.footer.autoChangeAlpha=YES;
//        
//        parameterNumber=num;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络请求出错"];
//    }];
//    [[NSOperationQueue mainQueue] addOperation:op];
//    
//    
//}
//
//
//
//#pragma mark  下拉刷新
//
//-(void)netWorkRequest2
//{
//    
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *myString = [userDefaultes stringForKey:@"myidt"];
//    
//    NSString *urlStr2 = [NSString stringWithFormat:@"%@/API/HDL_SNROilCard.ashx?action=getlist&q0=%@&q1=%d",urlt,myString,parameterNumber];
//    
//    NSLog(@"%@",urlStr2);
//    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        NSString *str = @"type=focus-c";
//        AFHTTPRequestOperation *op=  [self POSTurlString:urlStr2 parameters:str];
//        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSMutableDictionary *dict=responseObject;
//            if(![[dict objectForKey:@"ResultObject"] isEqual:[NSNull null]])
//            {
//                NSMutableArray *dictarr=[[dict objectForKey:@"ResultObject"] mutableCopy];
//                [self netwok:dictarr];
//                [self.tableview reloadData];
//            }
//            
//            [self.tableview.header endRefreshing];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            [MBProgressHUD showError:@"网络异常！"];
//            
//            return ;
//        }];
//        
//        [[NSOperationQueue mainQueue] addOperation:op];
//        
//    }];
//    self.tableview.header.autoChangeAlpha = YES;
//    [self.tableview.header beginRefreshing];
//    
//}
//
//
//
//

@end
