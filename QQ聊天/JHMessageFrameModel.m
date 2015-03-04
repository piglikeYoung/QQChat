//
//  NJMessageFrameModel.m
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHMessageFrameModel.h"
#import "JHMessageModel.h"

@implementation JHMessageFrameModel

-(void)setMessage:(JHMessageModel *)message
{
    _message = message;
    
    // 屏幕宽度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    // 间隙
    CGFloat padding = 10;
    
    // 1.时间
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeH = 30;
    CGFloat timeW = screenWidth;
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 2.头像
    CGFloat iconH = 30;
    CGFloat iconW = 30;
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    
    CGFloat iconX = 0;
    if (JHMessageModelTypeMe == _message.type) { // 自己发的
        // x = 屏幕宽度 - 间隙 - 头像宽度
        iconX = screenWidth - padding - iconW;
    } else {
        // 别人发的
        iconX = padding;
    }
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3.正文
    NSDictionary *dict = @{NSFontAttributeName : JHTextFont};
    CGSize maxSize = CGSizeMake(200, MAXFLOAT);
    CGSize  textSize = [_message.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    if (JHMessageModelTypeMe == _message.type) {
        // 自己发的
        // x = 头像x - 间隙 - 文本的宽度
        textX = iconX - padding - textW;
    }else
    {
        // 别人发的
        // x = 头像最大的X + 间隙
        textX = CGRectGetMaxX(_iconF) + padding;
    }
    _textF = CGRectMake(textX, textY, textW, textH);
}

@end
