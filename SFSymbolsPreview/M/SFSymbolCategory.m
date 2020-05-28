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
    return [self initWithCategoryName:categoryName imageNamed:nil];
}

- (instancetype)initWithCategoryName:(NSString *)categoryName imageNamed:(NSString *)imageNamed
{
    if( [super init] )
    {
        _name = categoryName;
        _imageNamed = imageNamed;
        
        [self loadSymbols];
    }
    return self;
}

- (void)loadSymbols
{
    static NSDictionary<NSString *, NSString *> *map;
    map = @{ @"All": @"SFSymbol.All",
             @"Communication": @"SFSymbol.Communication",
             @"Weather": @"SFSymbol.Weather",
             @"Objects & Tools": @"SFSymbol.Objects&Tools",
             @"Devices": @"SFSymbol.Devices",
             @"Connectivity": @"SFSymbol.Connectivity",
             @"Transportation": @"SFSymbol.Transportation",
             @"Nature": @"SFSymbol.Nature",
             @"Time": @"SFSymbol.Time",
             @"Health": @"SFSymbol.Health",
             @"Shapes": @"SFSymbol.Shapes"
    };
    
    if( map[self.name] )
    {
        [self loadSymbolsWithResource:map[self.name]];
    }
}

- (void)loadSymbolsWithResource:(NSString *)resource
{
    __block NSMutableArray<SFSymbol *> *symbolsPool = @[].mutableCopy;
    NSArray<NSString *> *symbolNames = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:resource ofType:@"plist"]];
    [symbolNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
        [symbolsPool addObject:[SFSymbol symbolWithName:name]];
    }];
    _symbols = (NSArray *)symbolsPool;
}

@end
