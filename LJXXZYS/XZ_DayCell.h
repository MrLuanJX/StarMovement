//
//  XZ_DayCell.h
//  LJXXZYS
//
//  Created by 栾金鑫 on 2019/4/14.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZ_DayCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UILabel * des;


@end
