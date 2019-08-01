//
//  MYCache.h
//  Deadlock
//
//  Created by huangkun on 2019/8/1.
//  Copyright © 2019 huangkun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCache : NSObject

- (void)setObject:(id)object forKey:(id <NSCopying>)key;

- (id)objectForKey:(id <NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
