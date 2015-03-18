//
//  CCConstants.m
//  Matched-Up
//
//  Created by Sakshi Jain on 19/03/15.
//  Copyright (c) 2015 Sakshi Jain. All rights reserved.
//

#import "CCConstants.h"

@implementation CCConstants

#pragma mark - User Class

NSString *const kCCCUserProfileKey              = @"profile";
NSString *const kCCUserProfileNameKey           = @"name";
NSString *const kccUserProfileFirstNameKey      = @"firstName";
NSString *const kccUserProfileLocationKey       = @"location";
NSString *const kccUserProfileGenderKey         = @"gender";
NSString *const kccUserProfileBirthdayKey       = @"birthday";
NSString *const kccUserProfileInterestedInKey   = @"interestedIn";
NSString *const kccUserProfilePictureURL        = @"pictureURL";

#pragma mark - Photo Class

NSString *const kCCCPhotoClassKey               = @"Photo"; //It's a class,so Key will start from Capital letter
NSString *const kCCCPhotoUserKey                = @"user";
NSString *const kCCCPhotoPictureKey             = @"image";

@end
