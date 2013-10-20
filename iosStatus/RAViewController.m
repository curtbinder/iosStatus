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

const int TIMEOUT_VALUE = 15;

@interface RAViewController ()
{
    RAController *_ra;
    RAHost *_host;
    NSMutableData *_xmlData;
    NSURLConnection *_conn;
}

@end

@implementation RAViewController

/*
- (void)loadView
{
    // Handle programmatically adding contents to the scroll view
    CGRect fullScreenRect = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    scrollView.contentSize = CGSizeMake(320, 758);
    
    // add any further subviews
    
    
    self.view = scrollView;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ra = [[RAController alloc] init];
    _host = [[RAHost alloc] init];
    _xmlData = nil;
    _conn = nil;
    
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
    NSURL *url = [[NSURL alloc] initWithString:address];
    NSLog(@"%@", url);
    // TODO allow to customize the timeout value
    NSURLRequest *req = [
                         [NSURLRequest alloc] initWithURL:url
                         cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                         timeoutInterval:TIMEOUT_VALUE];
    
    // create a new array for the xml data
    _xmlData = [NSMutableData dataWithCapacity:0];
    
    // create the connection
    _conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if ( ! _conn ) {
        _xmlData = nil;
        [self displayAlert:@"Error"
                          :[NSString stringWithFormat:@"Connection failed to: %@",
                            [_host getControllerUrlString]]];
    }
}

// Connection Delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // server has responded
    // can be called multiple times
    
    // set the data length to 0
    [_xmlData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // data was received, so append it to the array
    [_xmlData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // error occurred, notify the user of the error
    // free up the received data and possibly the connection
    _xmlData = nil;
    _conn = nil;
    
    // display the error
    NSString *msg = [NSString stringWithFormat:@"%@\n%@",
                     [error localizedDescription],
                     [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    [self displayAlert:@"Connection Failed" :msg];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // clear out the connection
    _conn = nil;
    
    // do something with the data
    [self parseData];
}

- (void)parseData
{
    NSLog(@"Parse XML data");
    
    // create and init parser object
    NSXMLParser *xml = [[NSXMLParser alloc] initWithData:_xmlData];
    // create and init our delegate
    RAXMLParser *parser = [[RAXMLParser alloc] initXMLParser];
    // set delegate
    [xml setDelegate:parser];
    // parse the data
    BOOL success = [xml parse];
    
    // test the result
    if ( success ) {
        NSLog(@"Successfully parsed");
        // save the data on success
        // clear out data after we have it saved
        _xmlData = nil;
    } else {
        // clear out the data on failure
        _xmlData = nil;
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
    NSUserDefaults *defs = (NSUserDefaults *)[notification object];
    [self setHostValues:[defs stringForKey:@"host_preference"]
                       :[defs stringForKey:@"port_preference"]
                       :[defs stringForKey:@"username_preference"]];
}

@end
