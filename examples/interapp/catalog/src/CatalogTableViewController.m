//
// Copyright 2011 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "CatalogTableViewController.h"

#import "NIRunApp.h"

typedef BOOL (^BasicBlockReturnBool)(void);

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation CatalogTableViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewStyle)style {
  if ((self = [super initWithStyle:style])) {
    self.title = NSLocalizedString(@"InterApp Catalog", @"");
  }
  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault
                                              animated: animated];
  
  UINavigationBar* navBar = self.navigationController.navigationBar;
  navBar.barStyle = UIBarStyleDefault;
  navBar.translucent = NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return NIIsSupportedOrientation(toInterfaceOrientation);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDataSource

/**
 * TODO (jverkoey July 20, 2011): This data source implementation is totally messy.
 * There *is* potential here so I might consider cleaning this up someday.
 */


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSArray *)rows {
  static NSArray* rows = nil;
  if (nil == rows) {
    rows = [NSArray arrayWithObjects:
            @"Generic",
            [NSDictionary dictionaryWithObjectsAndKeys: @"URL in Safari", @"title",
             [^{ return [NIRunApp safariWithURL:[NSURL URLWithString:@"http://jverkoey.github.com/nimbus"]];} autorelease], @"block", nil],

            @"Google Maps",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Location", @"title",
             [^{ return [NIRunApp googleMapAtLocation:CLLocationCoordinate2DMake(37.37165, -121.97877)];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Location with title", @"title",
             [^{ return [NIRunApp googleMapAtLocation:CLLocationCoordinate2DMake(37.37165, -121.97877)
                                                title:@"Trampoline Dodgeball"];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Directions", @"title",
             [^{ return [NIRunApp googleMapDirectionsFromLocation:CLLocationCoordinate2DMake(37.6139, -122.4871)
                                                       toLocation:CLLocationCoordinate2DMake(36.6039, -121.9116)];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Query for Boudin Bakeries", @"title",
             [^{ return [NIRunApp googleMapWithQuery:@"Boudin Bakeries"];} autorelease], @"block", nil],

            @"Phone",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp phone];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Call 123-456-7890", @"title",
             [^{ return [NIRunApp phoneWithNumber:@"123-456-7890"];} autorelease], @"block", nil],

            @"SMS",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp sms];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"SMS 123-456-7890", @"title",
             [^{ return [NIRunApp smsWithNumber:@"123-456-7890"];} autorelease], @"block", nil],

            @"Mail",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Mail to jverkoey@gmail.com", @"title",
             [^{ NIMailAppInvocation* invocation = [NIMailAppInvocation invocation];
              invocation.recipient = @"jverkoey+nimbus@gmail.com";
              return [NIRunApp mailWithInvocation:invocation];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Mail to jverkoey@gmail.com with a subject", @"title",
             [^{ NIMailAppInvocation* invocation = [NIMailAppInvocation invocation];
              invocation.recipient = @"jverkoey+nimbus@gmail.com";
              invocation.subject = @"Nimbus made me do it!";
              return [NIRunApp mailWithInvocation:invocation];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Mail to jverkoey@gmail.com with all details", @"title",
             [^{ NIMailAppInvocation* invocation = [NIMailAppInvocation invocation];
              invocation.recipient = @"jverkoey+nimbus@gmail.com";
              invocation.subject = @"Nimbus made me do it!";
              invocation.bcc = @"jverkoey+bcc@gmail.com";
              invocation.cc = @"jverkoey+cc@gmail.com";
              invocation.body = @"This will be an awesome email.";
              return [NIRunApp mailWithInvocation:invocation];} autorelease], @"block", nil],

            @"YouTube",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Ninja cat video", @"title",
             [^{ return [NIRunApp youTubeWithVideoId:@"fzzjgBAaWZw"];} autorelease], @"block", nil],

            @"iBooks",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp iBooks];} autorelease], @"block", nil],

            @"App Store",
            [NSDictionary dictionaryWithObjectsAndKeys: @"iBooks", @"title",
             [^{ return [NIRunApp appStoreWithAppId:@"364709193"];} autorelease], @"block", nil],
            
            @"Facebook",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp facebook];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Jeff's profile page", @"title",
             [^{ return [NIRunApp facebookProfileWithId:@"122605446"];} autorelease], @"block", nil],

            @"Twitter",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp twitter];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Post a tweet", @"title",
             [^{ return [NIRunApp twitterWithMessage:@"I'm playing with the Nimbus sample apps! http://jverkoey.github.com/nimbus"];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"featherless", @"title",
             [^{ return [NIRunApp twitterProfileForUsername:@"featherless"];} autorelease], @"block", nil],
            
            @"Instagram",
            [NSDictionary dictionaryWithObjectsAndKeys: @"Open the app", @"title",
             [^{ return [NIRunApp instagram];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"Camera", @"title",
             [^{ return [NIRunApp instagramCamera];} autorelease], @"block", nil],
            [NSDictionary dictionaryWithObjectsAndKeys: @"featherless", @"title",
             [^{ return [NIRunApp instagramProfileForUsername:@"featherless"];} autorelease], @"block", nil],

            nil];
    [rows retain];
  }
  return rows;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSArray* rows = [self rows];
  
  NSInteger numberOfSections = 0;
  for (id object in rows) {
    numberOfSections += [object isKindOfClass:[NSString class]];
  }
  
  return MAX(1, numberOfSections);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSArray* rows = [self rows];
  
  NSInteger sectionIndex = -1;
  for (id object in rows) {
    sectionIndex += [object isKindOfClass:[NSString class]];
    
    if (sectionIndex == section) {
      return object;
    }
  }
  
  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray* rows = [self rows];
  
  NSInteger sectionIndex = -1;
  NSInteger numberOfRows = 0;
  for (id object in rows) {
    sectionIndex += [object isKindOfClass:[NSString class]];
    
    if (sectionIndex == section && [object isKindOfClass:[NSDictionary class]]) {
      numberOfRows++;
    } else if (numberOfRows > 0) {
      break;
    }
  }
  
  return numberOfRows;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectForIndexPath:(NSIndexPath *)indexPath {
  // UGH: This is slow. Thankfully it doesn't matter because we know that we're only ever going to
  // have < 100 items or so.
  
  NSArray* rows = [self rows];
  
  NSInteger sectionIndex = -1;
  NSInteger rowIndex = -1;
  for (id object in rows) {
    sectionIndex += [object isKindOfClass:[NSString class]];
    
    if (sectionIndex == [indexPath section] && [object isKindOfClass:[NSDictionary class]]) {
      rowIndex++;
    } else if (rowIndex >= 0) {
      break;
    }
    
    if (rowIndex == [indexPath row] && sectionIndex == [indexPath section]) {
      return object;
    }
  }
  
  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath {
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"row"];
  
  if (nil == cell) {
    cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                   reuseIdentifier: @"row"]
            autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  id object = [self objectForIndexPath:indexPath];
  
  cell.textLabel.text = [object objectForKey:@"title"];
  
  return cell;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  id object = [self objectForIndexPath:indexPath];

  BasicBlockReturnBool block = [object objectForKey:@"block"];
  BOOL result = block();
  if (!result) {
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle: @"We've givin' her all she's got, cap'n!"
                                                     message: @"The app you tried to open does not appear to be installed on this device."
                                                    delegate: nil
                                           cancelButtonTitle: @"Oh well"
                                           otherButtonTitles: nil]
                          autorelease];
    [alert show];
  }
}


@end
