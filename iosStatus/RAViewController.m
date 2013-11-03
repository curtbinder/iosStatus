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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _ra = [[RAController alloc] init];
    _host = [[RAHost alloc] init];
    _xmlData = nil;
    _conn = nil;
    
    [self initExtraDisplaySettings];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [self setHostValues:[prefs stringForKey:@"host_preference"]
                       :[prefs stringForKey:@"port_preference"]
                       :[prefs stringForKey:@"username_preference"] ];
    
    // update labels from memory
    [self updateLabelNames];
    
    // update parameter values
    [self updateParameters];
}

- (void)initExtraDisplaySettings
{
    // set the switch outline to RED instead of the default WHITE
    self.port1.tintColor = [UIColor redColor];
    self.port2.tintColor = [UIColor redColor];
    self.port3.tintColor = [UIColor redColor];
    self.port4.tintColor = [UIColor redColor];
    self.port5.tintColor = [UIColor redColor];
    self.port6.tintColor = [UIColor redColor];
    self.port7.tintColor = [UIColor redColor];
    self.port8.tintColor = [UIColor redColor];
    
    self.port1Override.hidden = YES;
    self.port2Override.hidden = YES;
    self.port3Override.hidden = YES;
    self.port4Override.hidden = YES;
    self.port5Override.hidden = YES;
    self.port6Override.hidden = YES;
    self.port7Override.hidden = YES;
    self.port8Override.hidden = YES;
    
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
    // TODO change TRUE based on if we are connecting to the controller or not
    // TRUE - controller, FALSE - portal
    self.port1.on = [_ra.main isPortOn:1 :TRUE];
    self.port2.on = [_ra.main isPortOn:2 :TRUE];
    self.port3.on = [_ra.main isPortOn:3 :TRUE];
    self.port4.on = [_ra.main isPortOn:4 :TRUE];
    self.port5.on = [_ra.main isPortOn:5 :TRUE];
    self.port6.on = [_ra.main isPortOn:6 :TRUE];
    self.port7.on = [_ra.main isPortOn:7 :TRUE];
    self.port8.on = [_ra.main isPortOn:8 :TRUE];
    // update the visibility of the override buttons if the ports are overridden
    self.port1Override.hidden = [_ra.main isOverrideButtonShown:1];
    self.port2Override.hidden = [_ra.main isOverrideButtonShown:2];
    self.port3Override.hidden = [_ra.main isOverrideButtonShown:3];
    self.port4Override.hidden = [_ra.main isOverrideButtonShown:4];
    self.port5Override.hidden = [_ra.main isOverrideButtonShown:5];
    self.port6Override.hidden = [_ra.main isOverrideButtonShown:6];
    self.port7Override.hidden = [_ra.main isOverrideButtonShown:7];
    self.port8Override.hidden = [_ra.main isOverrideButtonShown:8];
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

- (IBAction)toggleButton:(id)sender
{
    // TODO move to relay view
    int port = 0;
    int status = PORT_STATE_AUTO;
    if ( sender == self.port1 ) {
        port = 1;
    } else if ( sender == self.port2 ) {
        port = 2;
    } else if ( sender == self.port3 ) {
        port = 3;
    } else if ( sender == self.port4 ) {
        port = 4;
    } else if ( sender == self.port5 ) {
        port = 5;
    } else if ( sender == self.port6 ) {
        port = 6;
    } else if ( sender == self.port7 ) {
        port = 7;
    } else if ( sender == self.port8 ) {
        port = 8;
    }
    
    if ( port == 0 ) {
        // sanity check to ensure we are only working with the ports we want
        return;
    }
    
    // set the values
    if ( [((UISwitch*)sender) isOn] ) {
        // toggle command on
        status = PORT_STATE_ON;
    } else {
        // toggle command off
        status = PORT_STATE_OFF;
    }
    // command is /rPS - where P is the port and S is the status
    
    // issue the command and then process the results
    // lastly update the screen (just like downloadParameters
    NSString *req = [NSString stringWithFormat:@"%@%d%d", REQ_RELAY, port, status];
    NSLog(@"Toggle: %@", req);
    [_host setRequest:req];
    [self sendCommand];
}

- (IBAction)clearPortOverride:(id)sender
{
    // TODO move to relay view
    // if we are configured for the portal, we will disable the button clicks from
    // the override buttons
    NSLog(@"Clear Port Override");
    int port = 0;
    if ( sender == self.port1Override ) {
        port = 1;
    } else if ( sender == self.port2Override ) {
        port = 2;
    } else if ( sender == self.port3Override ) {
        port = 3;
    } else if ( sender == self.port4Override ) {
        port = 4;
    } else if ( sender == self.port5Override ) {
        port = 5;
    } else if ( sender == self.port6Override ) {
        port = 6;
    } else if ( sender == self.port7Override ) {
        port = 7;
    } else if ( sender == self.port8Override ) {
        port = 8;
    }
    
    if ( port == 0 ) {
        // sanity check to ensure we are only working with the ports we want
        return;
    }
    
    NSString *req = [NSString stringWithFormat:@"%@%d%d", REQ_RELAY, port, PORT_STATE_AUTO];
    NSLog(@"Clear Override: %@", req);
    [_host setRequest:req];
    [self sendCommand];
    
    ((UIButton*)sender).hidden = YES;
}

- (void)downloadLabels
{
    // Download the labels from portal
    // Save them in a user preferences
    // Update labels on the display (call updateLabelNames)
}

- (void)downloadParameters
{
    [_host setRequest:REQ_STATUS];
    [self sendCommand];
}

- (void)sendCommand
{
    // TODO handle if configured to use Portal instead of Controller/Host
    if ( ! [self isHostConfigured] ) {
        return;
    }
    
    NSString *address = [_host getControllerUrlString];
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
    
    // TODO check the request type and update appropriately based on request
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
    [_host setHost:[host stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [_host setPort:[port stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [_host setUsername:[username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
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
