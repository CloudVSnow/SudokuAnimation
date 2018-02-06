//
//  ViewController.m
//  SudokuAnimation
//
//  Created by LiuTian on 2018/2/5.
//  Copyright © 2018年 CloudVSnow. All rights reserved.
//

#import "ViewController.h"
#import "RewardView.h"

typedef NS_ENUM(NSInteger,SpeedType) {
    Speed_One,
    Speed_Two,
    Speed_Three
};

@interface ViewController ()
@property(nonatomic,strong) NSMutableDictionary *viewIndexDic;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,assign) SpeedType speed;
@property(nonatomic,assign) CGFloat timeSpace;
@property(nonatomic,assign) CGFloat totalTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewIndexDic = [NSMutableDictionary dictionary];
    self.currentIndex  = 1;
    self.speed = Speed_One;
    self.timeSpace = 0;
    self.totalTime = 0;
    
    CGFloat startOX = ([UIScreen mainScreen].bounds.size.width-300)/4.0;
    NSArray *frameArray = @[[NSValue valueWithCGRect:CGRectMake(startOX, 100, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX*2+100, 100, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX*3+200, 100, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX*3+200, 100*2+startOX, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX*3+200, 100*3+2*startOX, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX*2+100, 100*3+2*startOX, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX, 100*3+2*startOX, 100, 100)],[NSValue valueWithCGRect:CGRectMake(startOX, 100*2+startOX, 100, 100)]];
    for (NSInteger i = 1; i<9; i++) {
        NSValue *value = frameArray[i-1];
        RewardView *view = [[RewardView alloc]initWithFrame:value.CGRectValue];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        [self.viewIndexDic setObject:view forKey:@(i)];
        if (i==1) {
            view.selectView.hidden = NO;
        }
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.frame = CGRectMake(2*startOX+100, 200+startOX, 100, 100);
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)animation{
    self.timeSpace = 0;
    if (self.currentIndex==9) {
        self.currentIndex=1;
    }
    NSInteger oldIndex = self.currentIndex-1;
    if (oldIndex==0) {
        oldIndex=8;
    }
    RewardView *oldView = [self.viewIndexDic objectForKey:@(oldIndex)];
    oldView.selectView.hidden = YES;
    RewardView *newView = [self.viewIndexDic objectForKey:@(_currentIndex)];
    newView.selectView.hidden = NO;
}

-(void)setTotalTime:(CGFloat)totalTime{
    _totalTime = totalTime;
    if (totalTime<=1.21) {
        self.speed = Speed_One;
    }else if (self.totalTime>1.21&&self.totalTime<=2.81){
        self.speed = Speed_Two;
    }else if(self.totalTime>13&&self.totalTime<14.81){
        self.speed = Speed_Two;
    }else if (self.totalTime>14.81){
        self.speed = Speed_One;
    }else{
        self.speed = Speed_Three;
    }
}

-(void)start{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (self.totalTime>16) {
            self.totalTime = 0;
            self.speed = Speed_One;
            self.timeSpace = 0;
            dispatch_source_cancel(timer);
        }else{
            self.timeSpace+=0.1;
            self.totalTime+=0.1;
            if (self.timeSpace>=0.4&&self.speed==Speed_One) {
                self.currentIndex++;
                [self animation];
            }else if (self.timeSpace>=0.2&&self.speed==Speed_Two){
                self.currentIndex++;
                [self animation];
            }else if (self.timeSpace>=0.1&&self.speed==Speed_Three){
                self.currentIndex++;
                [self animation];
            }
        }
        
    });
    dispatch_resume(timer);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
