//
//  NSString+Extension.m
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return textSize;
}

@end
