//
//  SFSymbolDatasource.h
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SFSymbolCategory.h"


@interface SFSymbolDatasource : NSObject

@property( nonatomic, strong, readonly ) NSArray<SFSymbolCategory *>        *categories;

+ (instancetype)datasource;

@end
