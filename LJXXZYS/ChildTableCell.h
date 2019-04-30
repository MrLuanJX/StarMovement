//
//  ChildTableCell.h
//  LJXXZYS
//
//  Created by a on 2019/4/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChildTableCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , copy) NSString * childModel;

@property (nonatomic , copy) NSString * model;


@end

NS_ASSUME_NONNULL_END
