//
//  main.m
//  test1
//
//  Created by 安井 惇 on 12/10/16.
//  Copyright (c) 2012年 安井 惇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>

struct task_basic_info
memory_size () {
    /** メモリー情報を取得するため、タスク情報を取る */
    struct task_basic_info basicInfo;
    mach_msg_type_number_t basicInfoCount = TASK_BASIC_INFO_COUNT;
    
    if (task_info(current_task(), TASK_BASIC_INFO, (task_info_t)&basicInfo, &basicInfoCount) != KERN_SUCCESS) {
        NSLog(@"%s", strerror(errno));
    }
	
    return basicInfo;
}

void
do_pressure_test1 () {
    /** メモリーとCPU時間に負荷をかけるプログラム */
    NSMutableArray* arr = [NSMutableArray new];
    NSInteger i = 0;
    
    for (i = 0; i < 500000; i++) {
        [arr addObject:@((NSInteger)(arc4random() % 500000))];
    }
    
    NSArray* result = [arr sortedArrayUsingComparator:^NSInteger(id num1 ,id num2) {
        NSInteger v1 = [num1 intValue];
        NSInteger v2 = [num2 intValue];
        if (v1 < v2) return NSOrderedAscending;
        if (v1 > v2) return NSOrderedDescending;
        return NSOrderedSame;
    }];
    
    // 総和を出す
    double fn = 0.0;
    for (NSNumber* num in result) {
        fn = [num intValue];
    }
    NSLog(@"Sum() => %lf", fn);
}

void
do_pressure_test2 () {
    /** メモリーとCPU時間に負荷をかけるプログラムが使用したメモリーを毎回破棄させる */
    @autoreleasepool {
        do_pressure_test1();
    }
}

void
run (void(*func)(void)) {
    /** 毎回、同じ回数のテストを実行させる */
    @autoreleasepool {
        double first = [[NSDate date] timeIntervalSince1970];
        NSInteger f = 0;
        for (f = 0; f < 10; f++) {
            double start = [[NSDate date] timeIntervalSince1970];
            func();
            double end = [[NSDate date] timeIntervalSince1970];
            
            struct task_basic_info mem = memory_size();
            NSLog(@"Finish Sort: %lf all %lf memory: %ld byte",
                  (end - start), (end - first), mem.resident_size);
        }
        struct task_basic_info mem = memory_size();
        NSLog(@"All Finish: %lf memory: %ld byte",
              ([[NSDate date] timeIntervalSince1970] - first), mem.resident_size);
        
    }
}

int
main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"========================================================");
        run(do_pressure_test1);
        NSLog(@"========================================================");
        run(do_pressure_test2);
        
    }
    return 0;
}

