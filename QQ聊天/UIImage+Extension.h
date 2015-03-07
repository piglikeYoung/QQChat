//
//  UIImage+Extension.h
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/5.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  传入图片的名称,返回一张可拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 可拉伸图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

@end
