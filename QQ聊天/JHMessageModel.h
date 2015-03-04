//
//  JHMessageModel.h
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHGlobal.h"

typedef enum
{
    NJMessageModelTypeMe = 0,
    NJMessageModelTypeOther
}JHMessageModelType;

@interface JHMessageModel : NSObject

/**
 *  正文
 */
@property (nonatomic, copy) NSString *text;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  消息类型
 */
@property (nonatomic, assign) JHMessageModelType type;

JHInitH(messageModel)

@end
