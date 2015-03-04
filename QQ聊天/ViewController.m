//
//  ViewController.m
//  QQ聊天
//
//  Created by piglikeyoung on 15/3/4.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "JHMessageModel.h"
#import "JHMessageCell.h"

@interface ViewController ()<UITableViewDataSource>

@property (strong , nonatomic) NSMutableArray *messages;

@property (weak , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            JHMessageModel *message = [JHMessageModel messageModelWithDict:dict];
            [models addObject:message];
        }
        self.messages = [models copy];
    }
    return _messages;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    JHMessageCell *cell = [JHMessageCell cellWithTableView:tableView];
    
    // 2.设置数据
    cell.message = self.messages[indexPath.row];
    
    // 3.返回cell
    return cell;
}

@end
