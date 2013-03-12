//
//  AssetTablePicker.m
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAssetTablePicker.h"
#import "ELCAssetCell.h"
#import "ELCAsset.h"
#import "ELCAlbumPickerController.h"

@implementation ELCAssetTablePicker

@synthesize parent;
@synthesize assetGroup, elcAssets;

-(void)viewDidLoad 
{
	[self.tableView setSeparatorColor:[UIColor clearColor]];
	[self.tableView setAllowsSelection:NO];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.elcAssets = tempArray;
	[self.navigationItem setTitle:@"Loading..."];
	self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    // Show partial while full list loads
	[self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:.5];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView reloadData];
}

-(void)preparePhotos
{
    NSLog(@"enumerating photos");
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) 
     {         
         if(result == nil) 
             return;
         ELCAsset *elcAsset = [[ELCAsset alloc] initWithAsset:result];
         [elcAsset setParent:self];
         elcAsset.tag = index;
         [self.elcAssets addObject:elcAsset];
     }];    
    NSLog(@"done enumerating photos");
	[self.tableView reloadData];
	[self.navigationItem setTitle:@"Pick Photos"];
}

- (void)do_next:(UIView *)sender
{
    NSMutableArray *selectedAssetsImages = [[NSMutableArray alloc] init];
	for(ELCAsset *elcAsset in self.elcAssets) 
    {		
        [selectedAssetsImages addObject:[elcAsset asset]];
	}
    [(ELCAlbumPickerController*)self.parent selectedAssets:selectedAssetsImages selectedIndex:sender.tag];
}

- (void) doneAction:(UIView *)sender 
{
    [self performSelector:@selector(do_next:) withObject:sender afterDelay:0.001f];
}

#pragma mark UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if(!ISPAD)
    {
        if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait)
            return ceil([self.assetGroup numberOfAssets] / 4.0);
        else
            return ceil([self.assetGroup numberOfAssets] / 6.0);
    }
    else
        return ceil([self.assetGroup numberOfAssets] / 4.0);
}

- (NSArray*)assetsForIndexPath:(NSIndexPath*)_indexPath 
{
	if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait)
    {
        int index = (_indexPath.row*4);
        int maxIndex = (_indexPath.row*4+3);
        if(maxIndex < [self.elcAssets count]) 
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    [self.elcAssets objectAtIndex:index+3],
                    nil];
        else if(maxIndex-1 < [self.elcAssets count])        
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    nil];
        else if(maxIndex-2 < [self.elcAssets count])
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    nil];
        else if(maxIndex-3 < [self.elcAssets count])
            return [NSArray arrayWithObject:[self.elcAssets objectAtIndex:index]];
        return nil;
    }
    else 
    {
        int index = (_indexPath.row*6);
        int maxIndex = (_indexPath.row*6+5);
        if(maxIndex < [self.elcAssets count]) 
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    [self.elcAssets objectAtIndex:index+3],
                    [self.elcAssets objectAtIndex:index+4],
                    [self.elcAssets objectAtIndex:index+5],
                    nil];
        else if(maxIndex-1 < [self.elcAssets count])        
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    [self.elcAssets objectAtIndex:index+3],
                    [self.elcAssets objectAtIndex:index+4],
                    nil];
        else if(maxIndex-2 < [self.elcAssets count])
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    [self.elcAssets objectAtIndex:index+3],
                    nil];
        else if(maxIndex-3 < [self.elcAssets count])
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    [self.elcAssets objectAtIndex:index+2],
                    nil];
        else if(maxIndex-4 < [self.elcAssets count])
            return [NSArray arrayWithObjects:[self.elcAssets objectAtIndex:index],
                    [self.elcAssets objectAtIndex:index+1],
                    nil];
        else if(maxIndex-5 < [self.elcAssets count])
            return [NSArray arrayWithObject:[self.elcAssets objectAtIndex:index]];
        return nil;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    ELCAssetCell *cell = (ELCAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = [[ELCAssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier];
	else 
		[cell setAssets:[self assetsForIndexPath:indexPath]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(ISPAD)
        return 129;
    else
        return 79;
}

@end
