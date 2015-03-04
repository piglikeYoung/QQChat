//
//  JHMessageCell.h
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHMessageModel,JHMessageFrameModel;

@interface JHMessageCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView;

@property (strong , nonatomic) JHMessageModel *message;

@end
