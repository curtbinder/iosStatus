//
//  RAViewController.m
//  ReefAngelStatus
//
//  Created by Curt Binder on 10/15/13.
//  Copyright (c) 2013 Curt Binder. All rights reserved.
//

#import "RAViewController.h"
#import "RAController.h"
#import "RAXMLParser.h"
#import "RAHost.h"

@interface RAViewController ()
{
    RAController *_ra;
    RAHost *_host;
}

@end

@implementation RAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ra = [[RAController alloc] init];
    _host = [[RAHost alloc] init];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [self setHostValues:[prefs stringForKey:@"host_preference"]
                       :[prefs stringForKey:@"port_preference"]
                       :[prefs stringForKey:@"username_preference"] ];
    
    
    // update labels from memory
    [self updateLabelNames];
    
    // update parameter values
    [self updateParameters];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // register for notifications when the view is visible
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(defaultPrefsChanged:)
                   name:NSUserDefaultsDidChangeNotification
                 object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // unregister for notifications when the view is hidden
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)updateParameters
{
    self.updateDate.text = _ra.updateDate;
    self.t1Value.text = _ra.t1.toString;
    self.t2Value.text = _ra.t2.toString;
    self.t3Value.text = _ra.t3.toString;
    self.phValue.text = _ra.ph.toString;
    self.dpValue.text = _ra.pwmD.toString;
    self.apValue.text = _ra.pwmA.toString;
    self.atolowValue.text = [NSString stringWithFormat:@"%@", _ra.atolow?@"ON":@"OFF"];
    self.atohighValue.text = [NSString stringWithFormat:@"%@", _ra.atohigh?@"ON":@"OFF"];
    self.salinityValue.text = _ra.salinity.toString;
    self.orpValue.text = _ra.orp.toString;
    self.pheValue.text = _ra.phe.toString;
    self.waterValue.text = _ra.water.toString;
}

- (void)updateLabelNames
{
    // load labels from memory
}

- (IBAction)refresh
{
    // download parameters from controller
    [self downloadParameters];
    
}

- (void)downloadLabels
{
    // Download the labels from portal
    // Save them in a user preferences
    // Update labels on the display (call updateLabelNames)
}

// TODO create download function that has a parameter for the type of request

- (void)downloadParameters
{
    // TODO handle if configured to use Portal instead of Controller/Host
    if ( ! [self isHostConfigured] ) {
        return;
    }
    
    // get the values in the /r99 format
    // store HOST and PORT inside settings
    NSString *address = [NSString stringWithFormat:@"%@/r99", [_host getControllerUrlString]];
    NSURL *url = [[NSURL alloc]initWithString:address];
    NSLog(@"%@", url);
    // store values in controller object
    
    // create and init parser object
    NSXMLParser *xml = [[NSXMLParser alloc] initWithContentsOfURL:url];
    // create and init our delegate
    RAXMLParser *parser = [[RAXMLParser alloc] initXMLParser];
    // set delegate
    [xml setDelegate:parser];
    // parse the data
    BOOL success = [xml parse];
    
    // test the result
    if ( success ) {
        NSLog(@"Successfully parsed");
    } else {
        NSLog(@"Error parsing");
        [self displayAlert:@"Error" :@"Error parsing XML data"];
        return;
    }
    
    // copy the controller value out
    _ra = [parser ra];
    
    // update parameters
    [self updateParameters];
}

- (BOOL)isHostConfigured
{
    if ( ! [_host isHostConfigured] ) {
        // empty host, no host set
        [self displayAlert:@"Invalid Host"
                          :@"Your host is not setup.\n\nPlease configure your host from the settings app."];
        return FALSE;
    }
    return TRUE;
}

- (void)displayAlert:(NSString *)title :(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

- (void)setHostValues:(NSString *)host :(NSString *)port :(NSString *)username
{
    [_host setHost:host];
    [_host setPort:port];
    [_host setUsername:username];
}

- (void)defaultPrefsChanged:(NSNotification *)notification
{
    // preferences changed, update values
    NSLog(@"prefs changed");
    NSUserDefaults *defs = (NSUserDefaults *)[notification object];
    [self setHostValues:[defs stringForKey:@"host_preference"]
                       :[defs stringForKey:@"port_preference"]
                       :[defs stringForKey:@"username_preference"]];
}

@end
