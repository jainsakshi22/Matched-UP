//
//  LoginViewController.m
//  Matched-Up
//
//  Created by Sakshi Jain on 17/03/15.
//  Copyright (c) 2015 Sakshi Jain. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndicator.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSArray *permisionArray = @[@"user_about_me",@"user_interests",@"user_relationships",@"user_birthday",@"user_location",@"user_relationship_details"];
    [PFFacebookUtils logInWithPermissions:permisionArray block:^(PFUser *user, NSError *error) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        if (!user)
        {
            if (!error)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"The Facebook Login was Cancelled" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message: [error description] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
            }
        }
        else
        {
            [self updateUserInformation];
            [self performSegueWithIdentifier:@"loginToTabBarSegue" sender:self];
        }
    }];
    
}

#pragma mark - Helper method

-(void)updateUserInformation
{
    // Send request to facebook
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
       // NSLog(@"%@",result);
        //handle response
      if (!error)
      {
        //Parse the data received
          NSDictionary *userDictionary = (NSDictionary *)result;
          NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
          if (userDictionary[@"name"])
          {
              userProfile[kCCUserProfileNameKey] = userDictionary[@"name"];
          }
          if (userDictionary[@"first_name"])
          {
              userProfile[kccUserProfileFirstNameKey] = userDictionary[@"first_name"];
          }
          if (userDictionary[@"location"][@"name"])
          {
              userProfile[kccUserProfileLocationKey] = userDictionary[@"location"][@"name"];
          }
          if (userDictionary[@"gender"])
          {
              userProfile[kccUserProfileGenderKey] = userDictionary[@"gender"];
          }
          if (userDictionary[@"birthday"])
          {
              userProfile[kccUserProfileBirthdayKey] = userDictionary[@"birthday"];
          }
          if (userDictionary[@"interested_in"])
          {
              userProfile[kccUserProfileInterestedInKey] = userDictionary[@"interested_in"];
          }
          
          [[PFUser currentUser] setObject:userProfile forKey:kCCCUserProfileKey];
          [[PFUser currentUser] saveInBackground];
      }
        else
        {
            NSLog(@"Error in facebook request %@",error);
        }
          
    }];
}








































































@end
