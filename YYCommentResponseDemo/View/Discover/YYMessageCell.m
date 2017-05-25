//
//  YYMessageCell.m
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYMessageCell.h"


@interface YYMessageCell() <UITableViewDelegate,UITableViewDataSource>
/* 用户名 */
@property (nonatomic, strong) UILabel *nameLabel;
/* 评论内容 */
@property (nonatomic, strong) UILabel *descLabel;
/* 用户头像 */
@property (nonatomic, strong) UIImageView *headImageView;
/* 回复的Tableview */
@property (nonatomic, strong) UITableView *tableView;
/* 更多按钮 */
@property (nonatomic, strong) UIButton *moreBtn;
/* 评论按钮 */
@property (nonatomic, strong) UIButton *commentBtn;
/* 图片浏览 */
@property (nonatomic, strong) JGGView *jggView;
/* 保存每个cell传进来的YYMessageModel */
@property (nonatomic, strong) YYMessageModel *messageModel;
/* 保存点击的cell */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YYMessageCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *YYMessageCellIdentifier = @"YYMessageCellIdentifier";
    YYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:YYMessageCellIdentifier];
    if (cell == nil) {
        cell = [[YYMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YYMessageCellIdentifier];
    }
    
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configLayout];
    }
    
    return self;
}

//MARK:-cell界面布局
- (void)configLayout {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //头像
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kGAP);
        make.width.height.mas_equalTo(kAvatar_Size);
    }];
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(kGAP);
//        make.width.height.mas_equalTo(kAvatar_Size);
//    }];
    //用户名
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor colorWithRed:(54/255.0) green:(71/255.0) blue:(121/255.0) alpha:0.9];
    self.nameLabel.preferredMaxLayoutWidth = screenWidth - kGAP-kAvatar_Size - 2*kGAP-kGAP;
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(-kGAP);
    }];
    
    //评论内容
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapText:)];
    [self.descLabel addGestureRecognizer:tapText];
    [self.contentView addSubview:self.descLabel];
    self.descLabel.preferredMaxLayoutWidth =screenWidth - kGAP-kAvatar_Size ;
    self.descLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [UIFont systemFontOfSize:13.0];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
    }];
    
    //全文 收起
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [self.moreBtn setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateSelected];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.moreBtn.selected = NO;
    [self.moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.descLabel.mas_bottom);
    }];
    
    //图片浏览
    self.jggView = [[JGGView alloc] init];
    [self.contentView addSubview:self.jggView];
    [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreBtn);
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(kGAP);
    }];
    
    //评论
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.backgroundColor = [UIColor whiteColor];
    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self.commentBtn setTitle:@"评论" forState:UIControlStateSelected];
    [self.commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.commentBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentBtn.layer.borderWidth = 1;
    self.commentBtn.layer.cornerRadius = 24/2;
    self.commentBtn.layer.masksToBounds = true;
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.commentBtn setImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateSelected];
    [self.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.descLabel);
        make.top.mas_equalTo(self.jggView.mas_bottom).offset(kGAP);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(24);
    }];
    
    //回复
    self.tableView = [[UITableView alloc] init];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:@"LikeCmtBg"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:image];
    [self.contentView addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jggView);
        make.top.mas_equalTo(self.commentBtn.mas_bottom).offset(kGAP);
        make.right.mas_equalTo(-kGAP);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hyb_lastViewInCell = self.tableView;
    self.hyb_bottomOffsetToCell = kGAP;
}

//MARK:-点击评论文字
- (void)tapText:(UITapGestureRecognizer *)tap {
    if (self.TapTextBlock) {
        UILabel *decLabel = (UILabel *)tap.view;
        self.TapTextBlock(decLabel);
    }
}
//MARK:-更多
-(void)moreAction:(UIButton *)sender{
    if (self.MoreBtnClickBlock) {
        self.MoreBtnClickBlock(sender,self.indexPath);
    }
}
//MARK:-评论
-(void)commentAction:(UIButton *)sender{
    if (self.CommentBtnClickBlock) {
        self.CommentBtnClickBlock(sender,self.indexPath);
    }
}
//MARK:-模型赋值
- (void)configCellWithModel:(YYMessageModel *)model indexPath:(NSIndexPath *)indexPath {
    
    self.messageModel = model;
    self.indexPath = indexPath;
    //用户名
    self.nameLabel.text = model.userName;
    
    //头像
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 3;//设置行间距离
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:model.message];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attrString.length)];//下划线
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
    self.descLabel.attributedText = attrString;
    self.descLabel.highlightedTextColor = [UIColor redColor];//设置文本高亮显示颜色，与highlighted一起使用。
    self.descLabel.highlighted = YES; //高亮状态是否打开
    self.descLabel.enabled = YES;//设置文字内容是否可变
    self.descLabel.userInteractionEnabled = YES;//设置标签是否忽略或移除用户交互。默认为NO
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName:muStyle};
    
    CGFloat h = [model.message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height+0.5;
    
    if (h<=60) {//对文字高度进行判断，若高度小于60，则隐藏更多按钮
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else{
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLabel);
            make.top.mas_equalTo(self.descLabel.mas_bottom);
        }];
    }
    
    if (model.isExpand) {//展开
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
            make.height.mas_equalTo(h);
        }];
    }else{//闭合
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kGAP);
            make.height.mas_lessThanOrEqualTo(60);
        }];
    }
    self.moreBtn.selected = model.isExpand;
    
    //布局评论图片
    CGFloat jjg_height = 0.0;
    CGFloat jjg_width = 0.0;
    if (model.messageBigPics.count>0&&model.messageBigPics.count<=3) {
        jjg_height = [JGGView imageHeight];
        jjg_width  = (model.messageBigPics.count)*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }else if (model.messageBigPics.count>3&&model.messageBigPics.count<=6){
        jjg_height = 2*([JGGView imageHeight]+kJGG_GAP)-kJGG_GAP;
        jjg_width  = 3*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }else  if (model.messageBigPics.count>6&&model.messageBigPics.count<=9){
        jjg_height = 3*([JGGView imageHeight]+kJGG_GAP)-kJGG_GAP;
        jjg_width  = 3*([JGGView imageWidth]+kJGG_GAP)-kJGG_GAP;
    }
    ///解决图片复用问题
    [self.jggView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ///布局九宫格
    [self.jggView JGGView:self.jggView DataSource:model.messageBigPics completeBlock:^(NSInteger index, NSArray *dataSource,NSIndexPath *indexpath) {
        self.tapImageBlock(index,dataSource,self.indexPath);
    }];
    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreBtn);
        make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(kJGG_GAP);
        make.size.mas_equalTo(CGSizeMake(jjg_width, jjg_height));
    }];
    
    //布局整个回复区域的size
    CGFloat tableViewHeight = 0;
    for (YYCommentModel *commentModel in model.commentModelArray) {
        CGFloat cellHeight = [YYCommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            YYCommentCell *cell = (YYCommentCell *)sourceCell;
            [cell configCellWithModel:commentModel];
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey : commentModel.commentId,
                     kHYBCacheStateKey : @"",
                     kHYBRecalculateForStateKey : @(YES)};
        }];
        tableViewHeight += cellHeight;
    }
    
    //更新回复区域高度
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight+30);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

//MARK:-------回复区域-----------
//MARK:-UITableViewDelegate DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYCommentCell *cell = [YYCommentCell cellWithTableView:tableView];
    if (self.messageModel.likeUsers.count) { //如果有赞的
        if (indexPath.row==0) {
            [cell configCellWithLikeUsers:self.messageModel.likeUsers];
            return cell;
        }
    }
    
    NSInteger index = self.messageModel.likeUsers.count?(indexPath.row-1):(indexPath.row);
    YYCommentModel *model = [self.messageModel.commentModelArray objectAtIndex:index];
    [cell configCellWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.messageModel.commentModelArray.count;
    if (self.messageModel.likeUsers.count) {//如果有赞的
        return count+1;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.messageModel.likeUsers.count) {//如果有赞的
        if (indexPath.row==0) {
            return 30;
        }
    }
    
    NSInteger index = self.messageModel.likeUsers.count?(indexPath.row-1):(indexPath.row);
    
    YYCommentModel *model = [self.messageModel.commentModelArray objectAtIndex:index];
    CGFloat cell_height = [YYCommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        YYCommentCell *cell = (YYCommentCell *)sourceCell;
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : model.commentId,
                                kHYBCacheStateKey : @"",
                                kHYBRecalculateForStateKey : @(NO)};
        return cache;
    }];
    return cell_height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.messageModel.likeUsers.count) {
        if (indexPath.row==0) {
            return;
        }
    }
    NSInteger index = self.messageModel.likeUsers.count?(indexPath.row-1):(indexPath.row);
    YYCommentModel *commentModel = [self.messageModel.commentModelArray objectAtIndex:index];
    CGFloat cell_height = [YYCommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        YYCommentCell *cell = (YYCommentCell *)sourceCell;
        [cell configCellWithModel:commentModel];
    } cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : commentModel.commentId,
                                kHYBCacheStateKey : @"",
                                kHYBRecalculateForStateKey : @(NO)};
        //        model.shouldUpdateCache = NO;
        return cache;
    }];
    
    //代理
    if ([self.delegate respondsToSelector:@selector(passCellHeight:commentModel:commentCell:messageCell:)]) {
        YYCommentCell *commetCell =  (YYCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        [self.delegate passCellHeight:cell_height commentModel:commentModel commentCell:commetCell messageCell:self];
        
    }
    
}


//MARK:-awakeFromNib
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end




















































