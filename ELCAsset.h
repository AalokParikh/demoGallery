//
//  Asset.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ELCAsset : UIView {
	ALAsset *asset;
	UIImageView *overlayView;
//	id parent;
}

@property (nonatomic,strong) ALAsset *asset;
@property (nonatomic, unsafe_unretained) id parent;

-(id)initWithAsset:(ALAsset*)_asset;

@end