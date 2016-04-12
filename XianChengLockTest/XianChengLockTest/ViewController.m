//
//  ViewController.m
//  XianChengLockTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{

//加锁
    NSLock *lock;//针对线程安全
    int ticketsCount;//票数
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    lock =[[NSLock alloc]init];//初始化
    ticketsCount=5;
    
    
    
    
    [NSThread detachNewThreadSelector:@selector(buyTicket1) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(buyTicket2) toTarget:self withObject:nil];
    
}
/*
 开发过程中，如遇到多个线程访问同一出资源的情况，一定要确保线程的资源访问安全性（先后顺序以及资源的真实存在情况）====解决方案：线程加锁、同步块来确保线程安全
 
 */
//甲买票的方法===一次五张
-(void)buyTicket1
{
    NSLog(@"甲");
    @synchronized(self) {//这是同步块。同步块内部的代码具有唯一性，（）里面的对象，如若检测到其他地方也访问当前（）里面的对象时都需要停下来等待同步块方法走完之后才可以运行
        if (ticketsCount>=5) {
            NSLog(@"甲买票，当前剩余票数%d",ticketsCount);
            ticketsCount-=5;
            NSLog(@"甲买票完成，当前剩余票数%d",ticketsCount);
        }

    }
    //上锁===防止其他线程抢占当前资源
//    [lock lock];
//    if (ticketsCount>=5) {
//        NSLog(@"甲买票，当前剩余票数%d",ticketsCount);
//        ticketsCount-=5;
//        NSLog(@"甲买票完成，当前剩余票数%d",ticketsCount);
//    }
//    NSLog(@"甲买票完成");
    //解锁==如果不解锁会导致后面的事件没办法执行
//    [lock unlock];
}
//乙买票的方法==一次一张
-(void)buyTicket2
{
    NSLog(@"乙");
    @synchronized(self) {
        if (ticketsCount>=1) {
            NSLog(@"乙买票，当前剩余票数%d",ticketsCount);
            ticketsCount-=1;
            NSLog(@"乙买票完成，当前剩余票数%d",ticketsCount);
            
        }
    }
//    [lock lock];
//    if (ticketsCount>=1) {
//        NSLog(@"乙买票，当前剩余票数%d",ticketsCount);
//        ticketsCount-=1;
//        NSLog(@"乙买票完成，当前剩余票数%d",ticketsCount);
//
//    }
//    NSLog(@"乙买票完成，当前剩余票数%d",ticketsCount);
    //解锁==如果不解锁会导致后面的事件没办法执行
//    [lock unlock];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
