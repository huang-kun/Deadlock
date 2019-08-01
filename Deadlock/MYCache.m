//
//  MYCache.m
//  Deadlock
//
//  Created by huangkun on 2019/8/1.
//  Copyright © 2019 huangkun. All rights reserved.
//

#import "MYCache.h"

@interface MYCache()
@property (nonatomic, strong) NSMutableDictionary *memoryStorage;
@property (nonatomic, strong) dispatch_queue_t storageQueue;
@end

@implementation MYCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _memoryStorage = [NSMutableDictionary new];
        _storageQueue = dispatch_queue_create("Storage Queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setObject:(id)object forKey:(id <NSCopying>)key {
    dispatch_barrier_async(self.storageQueue, ^{
        self.memoryStorage[key] = object;
    });
}

- (id)objectForKey:(id <NSCopying>)key {
    __block id object = nil;
    dispatch_sync(self.storageQueue, ^{
        object = self.memoryStorage[key];
    });
    return object;
}

@end
