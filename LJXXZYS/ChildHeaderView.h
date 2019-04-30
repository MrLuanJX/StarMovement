//
//  ChildHeaderView.h
//  LJXXZYS
//
//  Created by a on 2019/4/23.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ChildHeaderView;

//配置小图和大图
@protocol ChildHeaderViewDelegate <NSObject>
@required

- (void) backAction: (ChildHeaderView *) headView;

@end

@interface ChildHeaderView : UIView

@property (nonatomic , assign) BOOL isOpen;

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , weak) id <ChildHeaderViewDelegate> delegate;

@property (nonatomic , strong) ChildModel * childModel;

@property (nonatomic , copy) void(^TextViewHeightBlock)(CGFloat rowHeight);


@end

NS_ASSUME_NONNULL_END
