//
//  pinglunCell.h
//  运维通
//
//  Created by abc on 15/8/7.
//  Copyright (c) 2015年 ritacc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pinglunCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *lc;

@property (weak, nonatomic) IBOutlet UITextView *pl;



@end
