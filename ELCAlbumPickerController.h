//
//  AlbumPickerController.h
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import "MBProgressHUD.h"
//#import "CustomAlertView.h"

@interface ELCAlbumPickerController : UITableViewController <UIAlertViewDelegate>{
	
	NSMutableArray *assetGroups;
	NSOperationQueue *queue;
//	id parent;
    
    ALAssetsLibrary *library;
}

@property (nonatomic, unsafe_unretained) id parent;
@property (nonatomic,strong) NSMutableArray *assetGroups;
//@property (strong, nonatomic) MBProgressHUD *hud;

-(void)selectedAssets:(NSArray*)_assets selectedIndex:(NSInteger)_index;

@end

