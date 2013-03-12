//
//  ImageViewController.m
//  Funnix
//
//  Created by Rajesh Jain on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/CGImageProperties.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import <Twitter/Twitter.h>

@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize capturedImg;
@synthesize imgView;
@synthesize overlayImg;
@synthesize scrollview;
@synthesize pageControll;
@synthesize library;
@synthesize background;
@synthesize infoItems,newIndex;
bool err;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    assetGroups = [[NSMutableArray alloc] init];
    assets = [[NSMutableArray alloc] init];
    assetURLDictionaries = [[NSMutableArray alloc] init];
    background = YES;
    err = NO;
    // Do any additional setup after loading the view from its nib.
    thumbs = [[NSMutableArray alloc]init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.image = self.capturedImg;

    background = NO;
    self.scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    assetGroups = nil;
    assets = nil;
    assetURLDictionaries = nil;
    thumbs = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

#pragma mark - IBAction Methods

-(IBAction)retake:(id)sender
{
    self.scrollview  = Nil;
    self.imgView = Nil;
    self.overlayImg = Nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)album_View:(id)sender
{
    for (UIView *sub in self.scrollview.subviews) {
        [sub removeFromSuperview];
    }
    [self.view bringSubviewToFront:scrollview];
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];    
	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
	[elcPicker setDelegate:self];
    [self presentModalViewController:elcPicker animated:NO];
}


-(IBAction)changePage:(id)sender 
{
    NSLog(@"Befor: index %d currentPage %d",index,self.pageControll.currentPage);
    index = self.pageControll.currentPage;
    NSLog(@"After: index %d currenPage %d",index,self.pageControll.currentPage);
    CGRect frame = scrollview.frame;
    frame.origin.x = scrollview.frame.size.width * index;
    [scrollview scrollRectToVisible:frame animated:YES];
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info selectedIndex:(NSInteger)_index {
	[self dismissModalViewControllerAnimated:NO];
	
    for (UIView *v in [scrollview subviews]) {
        [v removeFromSuperview];
    }
    infoItems = [[NSArray alloc]initWithArray:info];
	CGRect workingFrame = scrollview.frame;
	workingFrame.origin.x = 0;
    int indexFrame = picker.selectedIndex;
    newIndex = indexFrame;
    for(int i = 0; i < [info count]; i++) 
    {
        NSDictionary *dict = [info objectAtIndex:i];
		UIImageView *imageview = [[UIImageView alloc] initWithImage:[dict objectForKey:UIImagePickerControllerOriginalImage]];
		[imageview setContentMode:UIViewContentModeScaleAspectFit];
		imageview.frame = workingFrame;
		imageview.tag = i;
        if(i >= indexFrame && i <= indexFrame + 9)
        {
            [scrollview addSubview:imageview];
            workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
        }
	}
    [scrollview setPagingEnabled:YES];
	[scrollview setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    [scrollview scrollRectToVisible:CGRectMake(0, 0, workingFrame.size.width, workingFrame.size.height) animated:NO];
    self.scrollview.hidden = NO;
//    self.pageControll.hidden = NO;
    self.pageControll.numberOfPages = [[scrollview subviews]count];
    index = 0;
    lastContentOffset = scrollview.contentOffset.x;
    NSLog(@"lastContentOffset %.2f",lastContentOffset);
    [self.view bringSubviewToFront:self.pageControll];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
	[self dismissModalViewControllerAnimated:NO];
    self.scrollview.hidden = YES;
    self.pageControll.hidden = YES;
}

#pragma mark - Scroll View Delegate Methods

-(void)reloadScrollViewWithNewImages
{
    for (UIView *v in [scrollview subviews]) {
        [v removeFromSuperview];
    }
	CGRect workingFrame = scrollview.frame;
	workingFrame.origin.x = 0;
    NSLog(@"reloadScrollView newIndex %d",newIndex);
    int indexFrame = newIndex;
    for(int i = 0; i < [infoItems count]; i++) 
    {
        NSDictionary *dict = [infoItems objectAtIndex:i];
		UIImageView *imageview = [[UIImageView alloc] initWithImage:[dict objectForKey:UIImagePickerControllerOriginalImage]];
		[imageview setContentMode:UIViewContentModeScaleAspectFit];
		imageview.frame = workingFrame;
		imageview.tag = i;
        if(i >= indexFrame && i <= indexFrame + 9)
        {
            [scrollview addSubview:imageview];
            workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
        }
	}
    [scrollview setPagingEnabled:YES];
	[scrollview setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    if(index == 0)
    {
        [scrollview scrollRectToVisible:CGRectMake((workingFrame.size.width*([[scrollview subviews]count]-1)), 0, workingFrame.size.width, workingFrame.size.height) animated:NO];
        index = [[scrollview subviews]count]-1;
        newIndex += [[scrollview subviews]count]-1;
    }
    else
    {
        index = 0;
        [scrollview scrollRectToVisible:CGRectMake(0, 0, workingFrame.size.width, workingFrame.size.height) animated:NO];
    }

    self.scrollview.hidden = NO;
//    self.pageControll.hidden = NO;

    self.pageControll.numberOfPages = [[scrollview subviews]count];
    NSLog(@"number %d",[[scrollview subviews]count]);
    lastContentOffset = scrollview.contentOffset.x;
    NSLog(@"reloadScrollView's lastContentOffset %.2f",lastContentOffset);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"ScrollViewDidEndDecelerating is called with subview(s) %d",[[scrollview subviews]count]); 
    if(lastContentOffset < scrollView.contentOffset.x)
    {
        
        index += (int)(scrollview.contentOffset.x - lastContentOffset)/scrollview.frame.size.width;
        newIndex += (int)(scrollview.contentOffset.x - lastContentOffset)/scrollview.frame.size.width;
        self.pageControll.currentPage = index;
        NSLog(@"Index incremented %d \n newIndex %d",index,newIndex);
        if(index == [[scrollView subviews]count]-1)
        {
            if(newIndex < [infoItems count]-1)
            {
                [self performSelector:@selector(reloadScrollViewWithNewImages)];
            }
        }
    }
    else if(lastContentOffset > scrollView.contentOffset.x)
    {
        index -= (int)(lastContentOffset - scrollview.contentOffset.x)/scrollview.frame.size.width;
        newIndex -= (int)(int)(lastContentOffset - scrollview.contentOffset.x)/scrollview.frame.size.width;
        self.pageControll.currentPage = index;
        NSLog(@"Index decremented %d \n newIndex %d",index,newIndex);
        if(index == 0)
        {
            if(newIndex > 0)
            {
                newIndex -= 9;
                if(newIndex < 0)
                    newIndex = 0;
                [self performSelector:@selector(reloadScrollViewWithNewImages)];
            }
        }
    }
    lastContentOffset = scrollView.contentOffset.x;
    NSLog(@"New lastContentOffset %.2f",lastContentOffset);
}

@end
