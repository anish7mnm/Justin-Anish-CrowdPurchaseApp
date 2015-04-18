//
//  DVYBasicAPIClient.h
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/18/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVYBasicAPIClient : NSObject


/**
 *  Makes an internet request to download the user's Profile Picture from the user Profile Picture link received from Facebook.
 *
 *  It takes in an NSString of the Image URL and returns the Image in as an NSData object (and not UIImage) on success and nothing on failure.
 */

+ (void) fetchingImageFromUserProfilePictureLinkString: (NSString *)profilePictureString withSuccessBlock: (void (^)(NSData * imageData))successBlock failureBlock: (void (^)(void))failureBlock;

@end
