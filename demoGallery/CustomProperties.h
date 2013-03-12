//
//  CustomProperties.h
//  Funnix
//
//  Created by Rajesh Jain on 23/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef Funnix_CutsomProperties_h
#define Funnix_CutsomProperties_h

#define kPreX                   5
#define kPreY                   2
#define kHeight                 64
#define kWidth                  64
#define kSubHeight              46

#define kPadPreX                5
#define kPadPreY                2
#define kPadHeight              128
#define kPadWidth               128

#define ksubScrollHideY         395
#define ksubScrollUnhideY       351
#define ksubScrollH             46
#define ksubScrollW             320

#define kPadsubScrollHideY      900
#define kPadsubScrollUnhideY    798
#define kPadsubScrollH          104
#define kPadsubScrollW          768

#define kButtonHiddenY          350
#define kButtonX                122
#define kButtonW                77
#define kButtonH                43
#define kButtonShownY           305

#define kAnimationDur           0.25f
#define kCameraViewTag          9999

#define kAccessToken        @"FBAccessTokenKey"
#define kAccessTokenDate    @"FBExpirationDateKey"

#define kAlbumName          @"Funnix"
#define kSaveSuccess        @"Photo successfully saved"

#define ISPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kThumbSize (ISPAD ? CGRectMake(0.0, 0.0, 125.0, 125.0) : (CGRectMake(0.0, 0.0, 75.0, 75.0)))
#define kSpacing (ISPAD ? 8.0 : 4.0)
#define kCapacityOfThumbsInARowPortrait 4.0
#define kCapacityOfThumbsInARowLandscape (ISPAD ? 4.0 : 6.0)
#define PAGE_GAP 20.0
#define kThumb (ISPAD ? 125.0 : 75.0)

#define kframeiPhonePortrait    CGRectMake(0, 0, 320, 416)
#define kframeiPhoneLandscap    CGRectMake(0, 0, 480, 256)
#define kframeiPadPortrait      CGRectMake(0, 0, 768, 918)
#define kframeiPadLandscap      CGRectMake(0, 0, 1024, 662)

#define kNameLabelTag       3699

#endif
