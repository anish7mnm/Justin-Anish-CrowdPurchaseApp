//
//  DVYBasicAPIClient.m
//  JACrowdPurchasingApp
//
//  Created by Anish Kumar on 4/18/15.
//  Copyright (c) 2015 Anish Kumar. All rights reserved.
//

#import "DVYBasicAPIClient.h"

@implementation DVYBasicAPIClient


+ (void) fetchingImageFromUserProfilePictureLinkString: (NSString *)profilePictureString withSuccessBlock: (void (^)(NSData *))successBlock failureBlock: (void (^)(void))failureBlock
{
  
    NSURL *pictureURL = [NSURL URLWithString:profilePictureString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError == nil && data != nil) {
                                   
                                   successBlock(data);
                                   
                               } else {
                                   
                                   NSLog(@"Failed to load profile photo.");
                                   failureBlock();
                                   
                               }
                           }];
    
}

@end
