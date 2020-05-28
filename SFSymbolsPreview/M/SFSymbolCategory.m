//
//  SFSymbolCategory.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SFSymbolCategory.h"


@interface SFSymbolCategory()

@end

@implementation SFSymbolCategory

- (instancetype)initWithCategoryName:(NSString *)categoryName
{
    if( [super init] )
    {
        _name = categoryName;
        
        [self loadSymbols];
    }
    return self;
}

- (void)loadSymbols
{
    if( [self.name isEqualToString:@"All"] )
    {
        [self loadAllSymbols];
    }
}

- (void)loadAllSymbols
{
    __block NSMutableArray<SFSymbol *> *symbolsPool = @[].mutableCopy;
    NSArray<NSString *> *symbolNames = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"SFSymbol.All" ofType:@"plist"]];
    [symbolNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
        [symbolsPool addObject:[SFSymbol symbolWithName:name]];
    }];
    _symbols = (NSArray *)symbolsPool;
}

@end
