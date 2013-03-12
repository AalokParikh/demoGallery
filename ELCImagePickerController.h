//
//  ELCImagePickerController.h
//  ELCImagePickerDemo
//
//  Created by Collin Ruffenach on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCImagePickerController : UINavigationController 

@property (nonatomic, unsafe_unretained) id delegate;
@property (assign, readwrite) NSInteger selectedIndex;

-(void)selectedAssets:(NSArray*)_assets selectedIndex:(NSInteger)_index;
-(void)cancelImagePicker;

@end

@protocol ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info selectedIndex:(NSInteger)_index;
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;

@end

