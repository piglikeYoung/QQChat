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
#import "JHMessageFrameModel.h"

@interface ViewController ()<UITableViewDataSource>

@property (strong , nonatomic) NSMutableArray *messages;

@property (weak , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置隐藏垂直的滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 设置tableview的背景颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
}

#pragma mark - 懒加载
- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            // 创建数据模型
            JHMessageModel *message = [JHMessageModel messageModelWithDict:dict];
            // 创建frame模型
            JHMessageFrameModel *mfm = [[JHMessageFrameModel alloc] init];
            mfm.message = message;
            
            [models addObject:mfm];
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
    cell.messageFrame = self.messages[indexPath.row];
    
    // 3.返回cell
    return cell;
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
