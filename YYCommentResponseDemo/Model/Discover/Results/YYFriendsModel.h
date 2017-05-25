//
//  YYFriendsModel.h
//  YYCommentResponseDemo
//
//  Created by Ryan on 2017/5/25.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYFriendsModel : NSObject

@property(nonatomic,copy)NSString *photo;

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *userId;

@property(nonatomic,copy)NSString *phoneNO;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
