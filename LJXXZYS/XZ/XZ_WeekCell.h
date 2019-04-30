//
//  XZ_WeekCell.h
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZ_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZ_WeekCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) XZ_Model * model;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
