//
//  QQTestCell.h
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QQTestCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier ;

@property (nonatomic , strong) QQModel * model;

@property (nonatomic , strong) NSIndexPath * index;

@end

NS_ASSUME_NONNULL_END
