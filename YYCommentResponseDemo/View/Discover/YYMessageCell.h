//
//  YYMessageCell.h
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMessageModel.h"
#import "YYCommentCell.h"
#import "JGGView.h"


@class YYMessageCell;
@protocol YYMessageCellDelegate <NSObject>

- (void)reloadCellHeightForModel:(YYMessageModel *)model atIndexPath:(NSIndexPath *)indexPath;

- (void)passCellHeight:(CGFloat )cellHeight commentModel:(YYCommentModel *)commentModel commentCell:(YYCommentCell *)commentCell messageCell:(YYMessageCell *)messageCell;

@end

@interface YYMessageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/* 评论按钮的block */
@property (nonatomic,copy) void (^CommentBtnClickBlock)(UIButton *commentBtn,NSIndexPath *indexPath);

/* 更多按钮的block */
@property (nonatomic,copy) void (^MoreBtnClickBlock)(UIButton *moreBtn,NSIndexPath *indexPath);

/* 点击图片的block */
@property (nonatomic, copy)TapBlcok tapImageBlock;

/* 点击文字的block */
@property (nonatomic, copy)void(^TapTextBlock)(UILabel *desLabel);

/* 代理 */
@property (nonatomic, weak) id<YYMessageCellDelegate> delegate;

/* 匹配模型 */
- (void)configCellWithModel:(YYMessageModel *)model indexPath:(NSIndexPath *)indexPath;

@end






























