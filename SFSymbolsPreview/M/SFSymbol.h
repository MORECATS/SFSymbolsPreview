//
//  SFSymbol.h
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SFSymbol : NSObject

@property( nonatomic, copy ) NSString                       *name;

+ (instancetype)symbolWithName:(NSString *)name;

@end
