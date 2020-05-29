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
    return [SFSymbol.alloc initWithName:name attributedName:nil];
}

+ (instancetype)symbolWithAttributedName:(NSAttributedString *)attributedName
{
    return [SFSymbol.alloc initWithName:attributedName.string attributedName:attributedName];
}

- (instancetype)initWithName:(NSString *)name attributedName:(NSAttributedString *)attributedName
{
    if( [super init] )
    {
        _name = name;
        _attributedName = attributedName;
    }
    return self;
}

@end
