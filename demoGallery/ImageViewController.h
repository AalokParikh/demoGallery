//
//  ImageViewController.h
//  Funnix
//
//  Created by Rajesh Jain on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCImagePickerController.h"

@interface ImageViewController : UIViewController<ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    NSMutableArray *assetGroups;
    NSMutableArray *assetURLDictionaries;
    NSMutableArray *assets;
    NSMutableArray *thumbs;
    NSInteger index;
    float lastContentOffset;
}

@property (nonatomic,strong) UIImage *capturedImg;
@property (nonatomic,strong) NSString *overlayImg;

@property (nonatomic,strong) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControll;

@property (strong, atomic) ALAssetsLibrary *library;
@property (assign, readwrite) BOOL background;

@property (strong, nonatomic) NSArray *infoItems;
@property (assign, atomic) int newIndex;

-(IBAction)retake:(id)sender;
-(IBAction)album_View:(id)sender;
-(IBAction)changePage:(id)sender;

@end
