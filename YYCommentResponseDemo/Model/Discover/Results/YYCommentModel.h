//
//  YYCommentModel.h
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//"commentId":"7",
//"commentUserId":274,
//"commentUserName":"文明",
//"commentPhoto":"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100",
//"commentText":"火车，福彩",
//"commentByUserId":274,
//"commentByUserName":"文明",
//"commentByPhoto":"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100",
//"createDate":1463126018000,
//"createDateStr":"2016-05-13 15:53",
//"checkStatus":"YES"

#import <Foundation/Foundation.h>

@interface YYCommentModel : NSObject

@property (nonatomic, assign) BOOL isExpand;

@property(nonatomic,copy)NSString *commentId;

@property(nonatomic,copy)NSString *commentUserId;

@property(nonatomic,copy)NSString *commentUserName;

@property(nonatomic,copy)NSString *commentPhoto;

@property(nonatomic,copy)NSString *commentText;
@property(nonatomic,copy)NSString *commentByUserId;
@property(nonatomic,copy)NSString *commentByUserName;
@property(nonatomic,copy)NSString *commentByPhoto;
@property(nonatomic,copy)NSString *createDateStr;
@property(nonatomic,copy)NSString *checkStatus;

///评论大图
@property(nonatomic,copy)NSMutableArray *messageBigPicArray;

// 评论数据源
@property (nonatomic,copy) NSMutableArray *commentModelArray;

//@property (nonatomic, assign) BOOL shouldUpdateCache;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
