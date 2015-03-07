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

@interface ViewController ()<UITableViewDataSource ,UITableViewDelegate, UITextFieldDelegate>

@property (strong , nonatomic) NSMutableArray *messages;

@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

/** 存放所有的自动回复数据 */
@property (strong , nonatomic) NSDictionary *autoReplays;

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
    
    // 设置cell不可以被选中
    self.tableView.allowsSelection = NO;
    
    // 注册键盘尺寸监听的通知
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
    
    // 给文本输入框添加左边的视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.inputTextField.leftView = view;
    // 设置左边视图的显示模式
    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // 监听键盘send按钮的点击
    self.inputTextField.delegate = self;
}

- (void)keyboardWillChange:(NSNotification *)notification
{
//    NSLog(@"键盘弹出,%@",notification);
    
    
    /*
     计算需要移动的距离
     弹出的时候移动的值 : 键盘的Y值 – 控制view的高度 = 要移动的距离
     -  480 = -216
     
     隐藏的时候移动的值 : 键盘的Y值 - 控制view的高度 = 要移动的距离
     480 -  480 = 0
     */
    
    // 1.获取键盘的Y值
    NSDictionary *dict = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获取动画执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    CGFloat translationY = keyboardY - self.view.frame.size.height;
    // 通过动画移动view
    /*
     [UIView animateWithDuration:duration animations:^{
     self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
     }];
     */
    
    /*
     输入框和键盘之间会由一条黑色的线条, 产生线条的原因是键盘弹出时执行动画的节奏和我们让控制器view移动的动画的节奏不一致导致
     */
    
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        // 需要执行动画的代码
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
    }];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // 创建自己发送的消息
    [self addMessage:textField.text type:JHMessageModelTypeMe];
    
    // 创建别人发送的消息
    NSString *result = [self autoReplayWithContent:textField.text];
    
    [self addMessage:result type:JHMessageModelTypeOther];
    
    // 2.刷新表格
    [self.tableView reloadData];
    
    // 3.让tableview滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    // 4.清空输入框
    self.inputTextField.text = nil;
    
    return YES;
}

-(void)addMessage:(NSString *)content type:(JHMessageModelType)type
{
    // 1.修改模型（创建模型，并且将模型保存到数组中）
    
    // 获取上一次的Message
    JHMessageModel *previousMessage = (JHMessageModel *)[[self.messages lastObject] message];
    
    JHMessageModel *message = [[JHMessageModel alloc] init];
    // 实现把当前时间作为发送时间
    NSDate *date = [NSDate date]; //创建时间对象
    // 可以将时间转换为字符串
    // 也可以将字符串转换为时间
    // 2014-05-31
    // 2014/05/31
    // 05/31/2014
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // HH 代表24小时 hh代表12小时
    formatter.dateFormat = @"HH:mm";
    message.time = [formatter stringFromDate:date];
    message.text = content;
    message.type = type;
    message.hiddenTime = [message.time isEqualToString:previousMessage.time];
    
    //根据message模型创建frame模型
    JHMessageFrameModel *mf = [[JHMessageFrameModel alloc] init];
    mf.message = message;
    
    [self.messages addObject:mf];
}

-(NSString *)autoReplayWithContent:(NSString *)content
{
    // 取出用户输入的每一个字
    NSString *result = nil;
    for (int i = 0; i<content.length; i++) {
        NSString *str = [content substringWithRange:NSMakeRange(i, 1)];
        
        result = self.autoReplays[str];
        if (result != nil) {//代表找到了自动回复的内容
            break;
        }
    }
    
    if (result == nil) {
        result = [NSString stringWithFormat:@"%@你个蛋",content];
    }
    return result;
}

#pragma mark - 懒加载
- (NSDictionary *)autoReplays
{
    if (_autoReplays == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"autoReplay.plist" ofType:nil];
        _autoReplays = [NSDictionary dictionaryWithContentsOfFile:fullPath];
    }
    return _autoReplays;
}

- (NSMutableArray *)messages
{
    if (_messages == nil) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        
        JHMessageModel *previousMessage = nil;
        // 记录上一次的消息模型
        for (NSDictionary *dict in dictArray) {
            // 1.创建数据模型
            JHMessageModel *message = [JHMessageModel messageModelWithDict:dict];
            
            // 获取上一次的数据模型
//            JHMessageModel *previousMessage = (JHMessageModel *)[[models lastObject] message];
            
            // 设置是否需要隐藏时间
            message.hiddenTime = [message.time isEqualToString:previousMessage.time];
            
            // 根据创建frame模型
            JHMessageFrameModel *mfm = [[JHMessageFrameModel alloc] init];
            
            mfm.message = message;
            
            [models addObject:mfm];
            
            previousMessage = message;// 这次的数据就是下一次循环中上次的数据
        }
        self.messages = [models mutableCopy];
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

#pragma mark - UITableViewDelegate
// 该方法有多少条数据就会调用多少次
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出frame的模型
    JHMessageFrameModel *mf = self.messages[indexPath.row];
    
    // 2.返回对应行的高度
    return mf.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 隐藏键盘
    [self.view endEditing:YES];
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
