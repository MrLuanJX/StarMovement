//
//  TodayCell.h
//  LJXXZYS
//
//  Created by a on 2019/4/16.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodayCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier ;

@property (nonatomic , strong) TodayModel * todayModel;

@end

NS_ASSUME_NONNULL_END
