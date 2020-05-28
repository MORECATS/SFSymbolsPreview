//
//  SFSymbol.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SFSymbol.h"


@interface SFSymbol()

@end

@implementation SFSymbol

+ (instancetype)symbolWithName:(NSString *)name
{
    return [SFSymbol.alloc initWithName:name];
}

- (instancetype)initWithName:(NSString *)name
{
    if( [super init] )
    {
        [self setName:name];
    }
    return self;
}

@end
