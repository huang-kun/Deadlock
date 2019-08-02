//
//  main.m
//  Deadlock
//
//  Created by huangkun on 2019/8/1.
//  Copyright © 2019 huangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWCache.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        RWCache *cache = [RWCache new];
        dispatch_queue_t testQueue = dispatch_queue_create("Test Queue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_group_t group = dispatch_group_create();
        for (int i = 0; i < 100; i++) {
            dispatch_group_async(group, testQueue, ^{
                [cache setObject:@(i) forKey:@(i)];
            });
            dispatch_group_async(group, testQueue, ^{
                [cache objectForKey:@(i)];
            });
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        printf("No deadlock! Program will exit as normal.\n");
    }
    return 0;
}
