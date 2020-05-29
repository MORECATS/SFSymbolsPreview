//
//  SymbolsViewController.h
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFSymbolCategory.h"
#import "SymbolPreviewCell.h"


@interface UIImage( SharingImageExtension )

- (UIImage *)toSize:(CGSize)size;

@end


@interface SymbolsViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property( nonatomic, assign ) SymbolPreviewingStyle                symbolPreviewingStyle;

@property( nonatomic, strong ) SFSymbolCategory                     *category;

@property( nonatomic, strong ) UICollectionView                     *collectionView;

- (instancetype)initWithCategory:(SFSymbolCategory *)category;

@end
