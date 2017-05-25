//
//  YYCommentCell.h
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCommentModel.h"

@interface YYCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tabelView;

///处理点赞的人列表
- (void)configCellWithLikeUsers:(NSArray *)likeUsers;
///处理评论的文字（包括xx回复yy）
- (void)configCellWithModel:(YYCommentModel *)model;

@end
