//
//  AssetTablePicker.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ELCAssetTablePicker : UITableViewController
{
//	ALAssetsGroup *assetGroup;
	
	NSMutableArray *elcAssets;
	int selectedAssets;
//	id parent;
	
	NSOperationQueue *queue;
}

@property (nonatomic, unsafe_unretained) id parent;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic,strong) NSMutableArray *elcAssets;

//-(int)totalSelectedAssets;
-(void)preparePhotos;

-(void)doneAction:(UIView *)sender;

@end

//@protocol ELCAssetTablePickerDelegate

//- (void)doneAction:(id)sender;

//@end