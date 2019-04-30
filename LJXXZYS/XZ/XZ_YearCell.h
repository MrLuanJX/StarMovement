//
//  XZ_YearCell.h
//  LJXXZYS
//
//  Created by a on 2019/4/15.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZ_YearModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZ_YearCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) XZ_YearModel * model;

@property (nonatomic , strong) NSIndexPath * index;

@end

NS_ASSUME_NONNULL_END
