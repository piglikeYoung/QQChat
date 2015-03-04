//
//  JHMessageCell.m
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHMessageCell.h"
#import "JHMessageFrameModel.h"
#import "JHMessageModel.h"

@interface JHMessageCell()

/** 时间 */
@property (weak , nonatomic) UILabel *timeLabel;

/** 正文 */
@property (weak , nonatomic) UIButton *contentBtn;

/** 头像 */
@property (weak , nonatomic) UIImageView *iconView;

@end

@implementation JHMessageCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"message";
    JHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JHMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


/*
 重写init方法是为让类一创建出来就拥有某些属性
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 添加将来有可能用到的子控件
        // 1.添加时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = JHTimeFont;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 2.添加正文
        UIButton *contentBtn = [[UIButton alloc] init];
        contentBtn.titleLabel.font = JHTextFont;
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 自动换行
        contentBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:contentBtn];
        self.contentBtn = contentBtn;
        
        // 3.添加头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 4.清空cell的背景颜色
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

@end
