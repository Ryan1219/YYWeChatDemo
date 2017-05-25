//
//  YYCommentModel.m
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "YYCommentModel.h"

@implementation YYCommentModel


- (NSMutableArray *)commentModelArray {
    if (_commentModelArray == nil) {
        _commentModelArray = [[NSMutableArray alloc] init];
    }
    return _commentModelArray;
}


-(NSMutableArray *)messageBigPics{
    if (_messageBigPicArray==nil) {
        _messageBigPicArray = [NSMutableArray array];
    }
    return _messageBigPicArray;
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.commentId          = dic[@"commentId"];
        self.commentUserId      = dic[@"commentUserId"];
        self.commentUserName    = dic[@"commentUserName"];
        self.commentPhoto       = dic[@"commentPhoto"];
        self.commentText        = dic[@"commentText"];
        self.commentByUserId    = dic[@"commentByUserId"];
        self.commentByUserName  = dic[@"commentByUserName"];
        self.commentByPhoto     = dic[@"commentByPhoto"];
        self.createDateStr      = dic[@"createDateStr"];
        self.checkStatus        = dic[@"checkStatus"];
    }
    return self;
}


@end
