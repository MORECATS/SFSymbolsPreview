//
//  SFSymbolDatasource.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SFSymbolDatasource.h"


static NSString *const kLastOpenedCategoryNameKey = @"LastOpenedCategoryName";


@interface SFSymbolDatasource()

@end

@implementation SFSymbolDatasource

+ (SFSymbolCategory *)lastOpenedCategeory
{
    NSString *name;
    __block SFSymbolCategory *lastOpenedCategory;
    
    name = [NSUserDefaults.standardUserDefaults stringForKey:kLastOpenedCategoryNameKey];
    if( name )
    {
        [SFSymbolDatasource.datasource.categories enumerateObjectsUsingBlock:^(SFSymbolCategory *category, NSUInteger index, BOOL *stop){
            if( [category.name isEqualToString:name] )
            {
                lastOpenedCategory = category;
                *stop = YES;
            }
        }];
    }
    return lastOpenedCategory ? : SFSymbolDatasource.datasource.categories.firstObject;
}

+ (void)storeUserActivityLastOpenedCategory:(SFSymbolCategory *)category
{
    [NSUserDefaults.standardUserDefaults setObject:category.name forKey:kLastOpenedCategoryNameKey];
}

- (void)loadCategories
{
    _categories = @[ [SFSymbolCategory.alloc initWithCategoryName:@"All" imageNamed:@"square.grid.2x2.fill"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Communication" imageNamed:@"message"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Weather" imageNamed:@"cloud.sun"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Object & Tools" imageNamed:@"folder"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Devices" imageNamed:@"desktopcomputer"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Connectivity" imageNamed:@"antenna.radiowaves.left.and.right"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Transportation" imageNamed:@"car.fill"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Human" imageNamed:@"person.crop.circle"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Nature" imageNamed:@"flame"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Editing" imageNamed:@"slider.horizontal.3"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Text Formatting" imageNamed:@"textformat"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Media" imageNamed:@"playpause"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Keyboard" imageNamed:@"command"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Commerce" imageNamed:@"cart"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Time" imageNamed:@"timer"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Health" imageNamed:@"staroflife"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Shapes" imageNamed:@"square.on.circle"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Arrows" imageNamed:@"arrow.right"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Indices" imageNamed:@"a.circle"],
                     [SFSymbolCategory.alloc initWithCategoryName:@"Math" imageNamed:@"x.squareroot"] ];
}

- (instancetype)init
{
    if( [super init] )
    {
        [self loadCategories];
    }
    return self;
}

+ (instancetype)datasource
{
    static SFSymbolDatasource *datasource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ datasource = SFSymbolDatasource.new; });
    return datasource;
}

@end
